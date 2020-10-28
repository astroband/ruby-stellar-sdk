module Stellar
  class MuxedAccount
    def to_keypair
      case arm
      when :ed25519 then KeyPair.from_public_key(value)
      when :med25519 then KeyPair.from_public_key(value.ed25519)
      else
        raise "impossible"
      end
    end

    def address
      to_keypair.address
    end
  end
end
