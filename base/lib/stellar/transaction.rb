module Stellar
  class Transaction
    include Stellar::Concerns::Transaction

    class << self
      #
      # @see  Stellar::Operation.payment
      def payment(attributes = {})
        make :payment, attributes
      end

      #
      # @see  Stellar::Operation.path_payment
      def path_payment(attributes = {})
        make :path_payment, attributes
      end

      #
      # @see  Stellar::Operation.path_payment_strict_receive
      def path_payment_strict_receive(attributes = {})
        make :path_payment_strict_receive, attributes
      end

      #
      # @see  Stellar::Operation.path_payment_strict_send
      def path_payment_strict_send(attributes = {})
        make :path_payment_strict_send, attributes
      end

      #
      # @see  Stellar::Operation.create_account
      def create_account(attributes = {})
        make :create_account, attributes
      end

      #
      # @see  Stellar::Operation.change_trust
      def change_trust(attributes = {})
        make :change_trust, attributes
      end

      #
      # @see  Stellar::Operation.manage_sell_offer
      def manage_sell_offer(attributes = {})
        make :manage_sell_offer, attributes
      end

      #
      # @see  Stellar::Operation.manage_buy_offer
      def manage_buy_offer(attributes = {})
        make :manage_buy_offer, attributes
      end

      #
      # @see  Stellar::Operation.create_passive_sell_offer
      def create_passive_sell_offer(attributes = {})
        make :create_passive_sell_offer, attributes
      end

      #
      # @see  Stellar::Operation.set_options
      def set_options(attributes = {})
        make :set_options, attributes
      end

      #
      # @see  Stellar::Operation.allow_trust
      def allow_trust(attributes = {})
        make :allow_trust, attributes
      end

      #
      # @see  Stellar::Operation.account_merge
      def account_merge(attributes = {})
        make :account_merge, attributes
      end

      #
      # @see  Stellar::Operation.inflation
      def inflation(attributes = {})
        make :inflation, attributes
      end

      #
      # @see  Stellar::Operation.manage_data
      def manage_data(attributes = {})
        make :manage_data, attributes
      end

      #
      # @see  Stellar::Operation.manage_data
      def bump_sequence(attributes = {})
        make :bump_sequence, attributes
      end

      #
      # DEPRECATED
      #
      # All methods calling make() have been deprecated in favor of Stellar::TransactionBuilder.
      # These functions only create single-operation transactions and essentially duplicate the
      # methods provided by Stellar::Operation. Stellar::TransactionBuilder enables the construction
      # of multi-operation transactions and mirrors the functionality provided by the Python and
      # JavaScript SDKs.
      #
      # Helper method to create a transaction with a single
      # operation of the provided type.  See class methods
      # on Stellar::Operation for available values for
      # operation_type.
      #
      # @see  Stellar::Operation
      #
      # @param operation_type [Symbol] the operation to use
      # @param attributes={} [Hash] attributes to use for both the transaction and the operation
      #
      # @return [Stellar::Transaction] the resulting transaction
      def make(operation_type, attributes = {})
        Stellar::Deprecation.warn(
          "Transaction.#{operation_type} is deprecated. Use Stellar::TransactionBuilder instead."
        )
        for_account(attributes).tap do |result|
          result.operations << Operation.send(operation_type, attributes)
        end
      end

      #
      # Helper method to create the skeleton of a transaction.
      # The resulting transaction will have its source account,
      # sequence, fee, min ledger and max ledger set.
      #
      #
      # @param attributes={} [type] [description]
      #
      # @return [Stellar::Transaction] the resulting skeleton
      def for_account(attributes = {})
        account = attributes[:account]
        sequence = attributes[:sequence]
        fee = attributes[:fee]

        raise ArgumentError, "Bad :account" unless account.is_a?(KeyPair)
        raise ArgumentError, "Bad :sequence #{sequence}" unless sequence.is_a?(Integer)
        raise ArgumentError, "Bad :fee #{sequence}" if fee.present? && !fee.is_a?(Integer)

        new.tap do |result|
          result.seq_num = sequence
          result.fee = fee
          result.memo = make_memo(attributes[:memo])
          result.source_account = account.muxed_account
          result.apply_defaults
        end
      end

      private

      def make_memo(memo)
        case memo
        when Stellar::Memo
          memo
        when nil
          nil
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
    end

    def to_v0
      ed25519 = if source_account.switch == Stellar::CryptoKeyType.key_type_ed25519
        source_account.ed25519!
      else
        source_account.med25519!.ed25519
      end

      TransactionV0.new(
        source_account_ed25519: ed25519,
        seq_num: seq_num,
        operations: operations,
        fee: fee,
        memo: memo,
        time_bounds: time_bounds,
        ext: ext
      )
    end

    def signature_base
      tagged_tx = Stellar::TransactionSignaturePayload::TaggedTransaction.new(:envelope_type_tx, self)
      Stellar::TransactionSignaturePayload.new(
        network_id: Stellar.current_network_id,
        tagged_transaction: tagged_tx
      ).to_xdr
    end

    def to_envelope(*key_pairs)
      signatures = (key_pairs || []).map(&method(:sign_decorated))

      TransactionEnvelope.v1(signatures: signatures, tx: self)
    end
  end
end
