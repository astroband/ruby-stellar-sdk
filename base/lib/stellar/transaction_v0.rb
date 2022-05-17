module Stellar
  class TransactionV0
    include Stellar::Concerns::Transaction

    def to_v1
      Transaction.new(
        **attributes.except(:source_account_ed25519, :time_bounds),
        cond: Stellar::Preconditions.new(:precond_time, time_bounds),
        source_account: source_account
      )
    end

    def to_envelope(*key_pairs)
      signatures = (key_pairs || []).map(&method(:sign_decorated))

      TransactionEnvelope.v0(signatures: signatures, tx: self)
    end

    def signature_base_prefix
      val = Stellar::EnvelopeType.envelope_type_tx_v0

      Stellar.current_network_id + Stellar::EnvelopeType.to_xdr(val)
    end

    # Backwards Compatibility: Use ENVELOPE_TYPE_TX to sign ENVELOPE_TYPE_TX_V0
    # we need a Transaction to generate the signature base
    def signature_base
      tx = Stellar::Transaction.from_xdr(
        # TransactionV0 is a transaction with the AccountID discriminant
        # stripped off, we need to put it back to build a valid transaction
        # which we can use to build a TransactionSignaturePayloadTaggedTransaction
        Stellar::PublicKeyType.to_xdr(Stellar::PublicKeyType.public_key_type_ed25519) + to_xdr
      )

      tagged_tx = Stellar::TransactionSignaturePayload::TaggedTransaction.new(:envelope_type_tx, tx)

      Stellar::TransactionSignaturePayload.new(
        network_id: Stellar.current_network_id,
        tagged_transaction: tagged_tx
      ).to_xdr
    end

    def source_account
      Stellar::MuxedAccount.ed25519(source_account_ed25519)
    end
  end
end
