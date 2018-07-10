module Stellar
  class SignerKey

    def self.ed25519(keypair)
      raise ArgumentError, "Bad keypair" unless keypair.is_a?(KeyPair)
      new(:signer_key_type_ed25519, keypair.raw_public_key)
    end


    def self.preauthorized_transaction(tx)
      new(:signer_key_type_pre_auth_tx, tx.hash)
    end


    def self.onetime_signer(preimage)
      hash_x = Digest::SHA256.digest(preimage)
      new(:signer_key_type_hash_x, hash_x)
    end

    def to_s
      case switch
      when SignerKeyType.signer_key_type_ed25519
        address = Stellar::Convert.pk_to_address(self)
        "ed25519: #{address}"
      when SignerKeyType.signer_key_type_pre_auth_tx
        tx = Stellar::Convert.to_hex(pre_auth_tx!)
        "pre_auth_tx: #{tx}"
      when SignerKeyType.signer_key_type_hash_x
        hx = Stellar::Convert.to_hex(hash_x!)
        "hash_x: #{hx}"
      end
    end

    def inspect
      label = switch.to_s
      "#<Stellar::SignerKey #{to_s}>"
    end

  end
end
