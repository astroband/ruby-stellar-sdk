module Stellar
  Transaction.class_eval do
    def sign(key_pair)
      hash = Digest::SHA256.digest(to_xdr)
      key_pair.sign(hash)
    end

    def to_envelope(*key_pairs)
      signatures = key_pairs.map(&method(:sign))
      
      TransactionEnvelope.new({
        :signatures => signatures,
        :tx => self
      })
    end
  end
end