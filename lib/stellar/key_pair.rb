module Stellar
  class KeyPair
    def self.from_seed(seed)
      seed_bytes = Util::Base58.stellar.check_decode(:seed, seed)
      secret_key = RbNaCl::SigningKey.new(seed_bytes)
      public_key = secret_key.verify_key
      new(public_key, secret_key)
    end

    def self.from_public_key(pk_bytes)
      public_key = RbNaCl::VerifyKey.new(pk_bytes)
      new(public_key)
    end

    def self.from_address(address)
      pk_bytes = Util::Base58.stellar.check_decode(:account_id, address)
      from_public_key(pk_bytes)
    end

    def self.random
      secret_key = RbNaCl::SigningKey.generate
      public_key = secret_key.verify_key
      new(public_key, secret_key)
    end

    def initialize(public_key, secret_key=nil)
      @public_key = public_key
      @secret_key = secret_key
    end

    def address
      pk_bytes = @public_key.to_bytes
      Util::Base58.stellar.check_encode(:account_id, pk_bytes)
    end

    def seed
      #TODO: raise some sort of error if we only have the public key
      seed_bytes = @secret_key.to_bytes
      encoder = Util::Base58.stellar.check_encode(:seed, seed_bytes)
    end

    def sign?
      !@secret_key.nil?
    end

    def sign(message)
      #TODO: raise some sort of error if we only have the public key
      @secret_key.sign(message)
    end

    def verify(signature, message)
      @public_key.verify(signature, message)
    end

  end
end