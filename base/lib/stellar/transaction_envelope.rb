module Stellar
  class TransactionEnvelope
    class << self
      def v0(tx:, signatures:)
        v0_envelope = TransactionV0Envelope.new(tx: tx, signatures: signatures)
        new(:envelope_type_tx_v0, v0_envelope)
      end

      def v1(tx:, signatures:)
        v1_envelope = TransactionV1Envelope.new(tx: tx, signatures: signatures)
        new(:envelope_type_tx, v1_envelope)
      end

      def fee_bump(tx:, signatures:)
        fee_bump_envelope = FeeBumpTransactionEnvelope.new(tx: tx, signatures: signatures)
        new(:envelope_type_tx_fee_bump, fee_bump_envelope)
      end
    end

    # Delegates any undefined method to the currently set arm
    def method_missing(method, *args, &block)
      case switch
      when EnvelopeType.envelope_type_tx_v0
        v0!.public_send(method, *args)
      when EnvelopeType.envelope_type_tx
        v1!.public_send(method, *args)
      when EnvelopeType.envelope_type_tx_fee_bump
        fee_bump!.public_send(method, *args)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      ["tx", "signatures"].include?(method) || super
    end

    # Checks to ensure that every signature for the envelope is
    # a valid signature of one of the provided `key_pairs`
    #
    # NOTE: this does not do any authorization checks, which requires access to
    # the current ledger state.
    #
    # @param key_pairs [Array<Stellar::KeyPair>] The key pairs to check the envelopes signatures against
    #
    # @return [Boolean] true if all signatures are from the provided key_pairs and validly sign the tx's hash
    def signed_correctly?(*key_pairs)
      hash = tx.hash
      return false if signatures.empty?

      key_index = key_pairs.index_by(&:signature_hint)

      signatures.all? do |sig|
        key_pair = key_index[sig.hint]
        break false if key_pair.nil?

        key_pair.verify(sig.signature, hash)
      end
    end

    def hash
      Digest::SHA256.digest(to_xdr)
    end

    def merge(other)
      merged_tx = tx.merge(other.tx)
      merged_tx.signatures = [signatures, other.signatures]
      merged_tx
    end
  end
end
