module Stellar
  class TransactionBuilder

    attr_reader :source_account, :sequence_number, :base_fee, :time_bounds, :time_bounds, :memo, :operations

    def initialize(
      source_account:, 
      sequence_number:, 
      base_fee: 100, 
      time_bounds: nil, 
      memo: nil
    )
      raise ArgumentError, "Bad :source_account" unless source_account.is_a?(Stellar::KeyPair)
      raise ArgumentError, "Bad :sequence_number" unless sequence_number.is_a?(Integer) && sequence_number >= 0
      raise ArgumentError, "Bad :time_bounds" unless time_bounds.is_a?(Stellar::TimeBounds) || time_bounds.nil?
      raise ArgumentError, "Bad :base_fee" unless base_fee.is_a?(Integer) && base_fee >= 100

      @source_account = source_account
      @sequence_number = sequence_number
      @base_fee = base_fee
      @time_bounds = time_bounds
      @memo = self.make_memo(memo)
      @operations = Array.new
    end

    def build
      if @time_bounds.nil?
        raise "TransactionBuilder.time_bounds must be set during initialization or by calling set_timeout"
      elsif !@time_bounds.min_time.is_a?(Integer) || !@time_bounds.max_time.is_a?(Integer)
        raise "TimeBounds.min_time and max_time must be Integers"
      elsif @time_bounds.max_time != 0 && @time_bounds.min_time > @time_bounds.max_time
        raise "Timebounds.max_time must be greater than min_time"
      end
      tx = Stellar::Transaction.new(
        source_account: @source_account.account_id,
        fee: @base_fee * @operations.length,
        seq_num: @sequence_number,
        time_bounds: @time_bounds,
        memo: @memo,
        operations: @operations,
        ext: Stellar::Transaction::Ext.new(0)
      )
      @sequence_number += 1
      tx
    end

    def add_operation(operation)
      raise ArgumentError, "Bad operation" unless operation.is_a? Stellar::Operation
      @operations.push(operation)
      self
    end

    def clear_operations()
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

      if timeout == 0
        @time_bounds.max_time = timeout
      else
        @time_bounds.max_time = Time.now.to_i + timeout
      end

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
      when Stellar::Memo ;
        memo
      when nil ;
        Memo.new(:memo_none)
      when Integer ;
        Memo.new(:memo_id, memo)
      when String ;
        Memo.new(:memo_text, memo)
      when Array ;
        t, val = *memo
        Memo.new(:"memo_#{t}", val)
      else
        raise ArgumentError, "Bad :memo"
      end
    end

  end
end