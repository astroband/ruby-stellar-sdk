module Stellar
  class TransactionEnvelope
    delegate :tx, :signatures, to: :value
    delegate :hash, to: :tx

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
      return false if signatures.empty?

      tx_hash = tx.hash
      keys_by_hint = key_pairs.index_by(&:signature_hint)

      signatures.all? do |sig|
        key_pair = keys_by_hint[sig.hint]
        break false if key_pair.nil?

        key_pair.verify(sig.signature, tx_hash)
      end
    end

    def signed_by?(keypair)
      signatures.any? do |sig|
        next if sig.hint != keypair.signature_hint

        keypair.verify(sig.signature, tx.hash)
      end
    end

    def merge(other)
      merged_tx = tx.merge(other.tx)
      merged_tx.signatures = [signatures, other.signatures]
      merged_tx
    end
  end
end
