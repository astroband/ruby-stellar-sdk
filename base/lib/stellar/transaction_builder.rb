module Stellar
  class TransactionBuilder
    include Stellar::DSL

    attr_reader :source_account, :sequence_number, :base_fee,
      :time_bounds, :memo, :operations, :ledger_bounds

    # If you want to prepare a transaction which will be valid only while the
    # account sequence number is
    #
    #     min_account_sequence <= source_account_sequence < tx.seq_num
    #
    # you can set min_account_sequence attribute
    #
    # Note that after execution the account's sequence number is always raised to `tx.seq_num`
    attr_accessor :min_account_sequence

    class << self
      # This enable user to call shortcut methods, like
      # TransactionBuilder.payment(...),
      # TransactionBuilder.manage_data(...) and etc.
      # It reduces the boilerplate, when you just need to
      # shoot a single operation in transaction
      def method_missing(method_name, *args, **kwargs)
        return super unless Operation.respond_to?(method_name)

        op = Operation.send(
          method_name,
          **kwargs.except(
            :source_account, :sequence_number, :base_fee, :time_bounds, :memo
          )
        )

        new(**kwargs).add_operation(op).build
      end

      def respond_to_missing?(method_name, include_private = false)
        Stellar::Operation.respond_to?(method_name) || super
      end
    end

    def initialize(
      source_account:,
      sequence_number:,
      base_fee: 100,
      time_bounds: nil,
      ledger_bounds: nil,
      memo: nil,
      min_account_sequence: nil,
      min_account_sequence_age: nil,
      min_account_sequence_ledger_gap: nil,
      extra_signers: [],
      **_ # ignore any additional parameters without errors
    )
      raise ArgumentError, "Bad :sequence_number" unless sequence_number.is_a?(Integer) && sequence_number >= 0
      raise ArgumentError, "Bad :time_bounds" unless time_bounds.is_a?(Stellar::TimeBounds) || time_bounds.nil?
      raise ArgumentError, "Bad :base_fee" unless base_fee.is_a?(Integer) && base_fee >= 100

      @source_account = Account(source_account)
      @sequence_number = sequence_number
      @base_fee = base_fee
      @time_bounds = time_bounds
      @ledger_bounds = ledger_bounds
      @min_account_sequence = min_account_sequence
      @min_account_sequence_age = min_account_sequence_age
      @min_account_sequence_ledger_gap = min_account_sequence_ledger_gap
      @extra_signers = extra_signers.clone

      set_timeout(0) if time_bounds.nil?

      @memo = make_memo(memo)
      @operations = []
    end

    def build
      if @time_bounds.nil?
        raise "TransactionBuilder.time_bounds must be set during initialization or by calling set_timeout"
      elsif !@time_bounds.min_time.is_a?(Integer) || !@time_bounds.max_time.is_a?(Integer)
        raise "TimeBounds.min_time and max_time must be Integers"
      elsif @time_bounds.max_time != 0 && @time_bounds.min_time > @time_bounds.max_time
        raise "Timebounds.max_time must be greater than min_time"
      end

      attrs = {
        source_account: @source_account.muxed_account,
        fee: @base_fee * @operations.length,
        seq_num: @sequence_number,
        memo: @memo,
        operations: @operations,
        cond: build_preconditions,
        ext: Stellar::Transaction::Ext.new(0)
      }

      @sequence_number += 1

      Stellar::Transaction.new(attrs)
    end

    def build_fee_bump(inner_txe:)
      if inner_txe.switch == Stellar::EnvelopeType.envelope_type_tx_v0
        inner_txe = Stellar::TransactionEnvelope.v1(tx: inner_txe.tx.to_v1, signatures: inner_txe.signatures)
      elsif inner_txe.switch != Stellar::EnvelopeType.envelope_type_tx
        raise ArgumentError, "Invalid inner transaction type #{inner_txe.switch}"
      end

      inner_tx = inner_txe.tx
      inner_ops = inner_tx.operations
      inner_base_fee_rate = inner_tx.fee.fdiv(inner_ops.length)

      # The fee rate for fee bump is at least the fee rate of the inner transaction
      if @base_fee < inner_base_fee_rate
        raise "Insufficient base_fee, it should be at least #{inner_base_fee_rate} stroops."
      end

      Stellar::FeeBumpTransaction.new(
        fee_source: @source_account.muxed_account,
        fee: @base_fee * (inner_ops.length + 1),
        inner_tx: Stellar::FeeBumpTransaction::InnerTx.new(:envelope_type_tx, inner_txe.v1!),
        ext: Stellar::FeeBumpTransaction::Ext.new(0)
      )
    end

    def add_operation(operation)
      raise ArgumentError, "Bad operation" unless operation.is_a? Stellar::Operation
      @operations.push(operation)
      self
    end

    def clear_operations
      @operations.clear
      self
    end

    def set_source_account(account_kp)
      raise ArgumentError, "Bad source account" unless account_kp.is_a?(Stellar::KeyPair)
      @source_account = account_kp
      self
    end

    def set_sequence_number(seq_num)
      raise ArgumentError, "Bad sequence number" unless seq_num.is_a?(Integer) && seq_num >= 0
      @sequence_number = seq_num
      self
    end

    def set_timeout(timeout)
      if !timeout.is_a?(Integer) || timeout < 0
        raise ArgumentError, "Timeout must be a non-negative integer"
      end

      if @time_bounds.nil?
        @time_bounds = Stellar::TimeBounds.new(min_time: 0, max_time: nil)
      end

      @time_bounds.max_time = (timeout == 0) ? timeout : Time.now.to_i + timeout

      self
    end

    # If you want to prepare a transaction which will only be valid within some
    # range of ledgers, you can set a `ledger_bounds` precondition.
    def set_ledger_bounds(min_ledger, max_ledger)
      if min_ledger < 0
        raise ArgumentError, "min_ledger cannot be negative"
      end

      if max_ledger < 0
        raise ArgumentError, "max_ledger cannot be negative"
      end

      if max_ledger > 0 && min_ledger > max_ledger
        raise ArgumentError, "min_ledger cannot be greater than max_ledger"
      end

      @ledger_bounds = Stellar::LedgerBounds.new(
        min_ledger: min_ledger,
        max_ledger: max_ledger
      )

      self
    end

    # For the transaction to be valid, the current ledger time must be at least
    # `min_account_sequence_age` greater than source account's `sequence_time`
    def min_account_sequence_age=(duration_in_seconds)
      unless duration_in_seconds.is_a?(Integer)
        raise ArgumentError, "min_account_sequence_age must be a number"
      end

      if duration_in_seconds < 0
        raise ArgumentError, "min_account_sequence_age cannot be negative"
      end

      @min_account_sequence_age = duration_in_seconds
    end

    # For the transaction to be valid, the current ledger number must be at least
    # `minAccountSequenceLedgerGap` greater than sourceAccount's ledger sequence.
    def min_account_sequence_ledger_gap=(gap)
      if gap < 0
        raise ArgumentError, "min_account_sequence_ledger_gap cannot be negative"
      end

      @min_account_sequence_ledger_gap = gap
    end

    # For the transaction to be valid, there must be a signature corresponding to
    # every Signer in this array, even if the signature is not otherwise required
    # by the sourceAccount or operations
    def set_extra_signers(extra_signers)
      unless extra_signers.is_a?(Array)
        raise ArgumentError, "extra_signers must be an array of strings"
      end

      if extra_signers.size > 2
        raise ArgumentError, "extra_signers cannot be longer than 2 elements"
      end

      @extra_signers = extra_signers.clone

      self
    end

    def set_memo(memo)
      @memo = make_memo(memo)
      self
    end

    def set_base_fee(base_fee)
      raise ArgumentError, "Bad base fee" unless base_fee.is_a?(Integer) && base_fee >= 100
      @base_fee = base_fee
      self
    end

    def make_memo(memo)
      case memo
      when Stellar::Memo
        memo
      when nil
        Memo.new(:memo_none)
      when Integer
        Memo.new(:memo_id, memo)
      when String
        Memo.new(:memo_text, memo)
      when Array
        t, val = *memo
        Memo.new(:"memo_#{t}", val)
      else
        raise ArgumentError, "Bad :memo"
      end
    end

    private

    def has_v2_preconditions?
      !(
        @ledger_bounds.nil? &&
        @min_account_sequence.nil? &&
        @min_account_sequence_age.nil? &&
        @extra_signers.empty? &&
        @min_account_sequence_ledger_gap.nil?
      )
    end

    def build_preconditions
      return Stellar::Preconditions.new(:precond_time, @time_bounds) unless has_v2_preconditions?

      Stellar::Preconditions.new(
        :precond_v2,
        Stellar::PreconditionsV2.new(
          time_bounds: @time_bounds,
          ledger_bounds: @ledger_bounds,
          min_seq_num: @min_account_sequence,
          min_seq_age: @min_account_sequence_age,
          min_seq_ledger_gap: @min_account_sequence_ledger_gap,
          extra_signers: @extra_signers.map { |signer| SignerKey(signer) }
        )
      )
    end
  end
end
