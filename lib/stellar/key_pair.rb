module Stellar
  class KeyPair
    def self.from_seed(seed_bytes)
      secret_key = RbNaCl::SigningKey.new(seed_bytes)
      public_key = secret_key.verify_key
      new(public_key, secret_key)
    end

    def self.from_public_key(public_key_bytes)
      public_key = RbNaCl::VerifyKey.new(public_key_bytes)
      new(public_key)
    end

    def self.from_address(address)
      raise NotImplementedError

      public_key_bytes = nil #TODO: base58check decode address into public key
      from_public_key(public_key_bytes)
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
      raise NotImplementedError
      # TODO: encode @public_key.to_bytes to base58check
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