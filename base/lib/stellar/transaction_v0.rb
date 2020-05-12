module Stellar
  class TransactionV0
    include Stellar::Concerns::Transaction

    def to_envelope(*key_pairs)
      signatures = (key_pairs || []).map(&method(:sign_decorated))

      TransactionEnvelope.v0(signatures: signatures, tx: self)
    end

    def signature_base_prefix
      val = Stellar::EnvelopeType.envelope_type_tx_v0

      Stellar.current_network_id + Stellar::EnvelopeType.to_xdr(val)
    end

    def source_account
      self.source_account_ed25519
    end
  end
end
