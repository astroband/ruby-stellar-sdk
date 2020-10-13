module Stellar
  class KeyPair
    module FactoryMethods
      def from_seed(seed)
        seed_bytes = Util::StrKey.check_decode(:seed, seed)
        from_raw_seed seed_bytes
      end

      def from_raw_seed(seed_bytes)
        secret_key = RbNaCl::SigningKey.new(seed_bytes)
        public_key = secret_key.verify_key
        new(public_key, secret_key)
      end

      def from_public_key(pk_bytes)
        public_key = RbNaCl::VerifyKey.new(pk_bytes)
        new(public_key)
      end

      def from_address(address)
        pk_bytes = Util::StrKey.check_decode(:account_id, address)
        from_public_key(pk_bytes)
      end

      def random
        secret_key = RbNaCl::SigningKey.generate
        public_key = secret_key.verify_key
        new(public_key, secret_key)
      end

      def from_network_passphrase(passphrase)
        network_id = Digest::SHA256.digest(passphrase)
        from_raw_seed network_id
      end

      def master
        from_raw_seed(Stellar.current_network_id)
      end
    end

    extend FactoryMethods

    def initialize(public_key, secret_key = nil)
      @public_key = public_key
      @secret_key = secret_key
    end

    def account_id
      Stellar::AccountID.new :public_key_type_ed25519, raw_public_key
    end

    def muxed_account
      Stellar::MuxedAccount.new :key_type_ed25519, raw_public_key
    end

    def public_key
      Stellar::PublicKey.new :public_key_type_ed25519, raw_public_key
    end

    def signer_key
      Stellar::SignerKey.new :signer_key_type_ed25519, raw_public_key
    end

    def raw_public_key
      @public_key.to_bytes
    end

    def signature_hint
      # take last 4 bytes
      account_id.to_xdr.slice(-4, 4)
    end

    def raw_seed
      @secret_key.to_bytes
    end

    def rbnacl_signing_key
      @secret_key
    end

    def rbnacl_verify_key
      @public_key
    end

    def address
      pk_bytes = raw_public_key
      Util::StrKey.check_encode(:account_id, pk_bytes)
    end

    def seed
      raise "no private key" if @secret_key.nil?
      # TODO: improve the error class above
      seed_bytes = raw_seed
      Util::StrKey.check_encode(:seed, seed_bytes)
    end

    def sign?
      !@secret_key.nil?
    end

    def sign(message)
      raise "no private key" if @secret_key.nil?
      # TODO: improve the error class above
      @secret_key.sign(message)
    end

    def sign_decorated(message)
      raw_signature = sign(message)
      Stellar::DecoratedSignature.new({
        hint: signature_hint,
        signature: raw_signature
      })
    end

    def verify(signature, message)
      @public_key.verify(signature, message)
    rescue RbNaCl::LengthError
      false
    rescue RbNaCl::BadSignatureError
      false
    end

    def to_keypair
      self
    end
  end
end
