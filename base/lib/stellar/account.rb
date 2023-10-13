module Stellar
  class Account
    def self.random
      keypair = Stellar::KeyPair.random
      new(keypair)
    end

    def self.from_seed(seed)
      keypair = Stellar::KeyPair.from_seed(seed)
      new(keypair)
    end

    def self.from_address(address)
      muxed_xdr = Util::StrKey.decode_muxed_account(address)

      if muxed_xdr.ed25519
        new(KeyPair.from_public_key(muxed_xdr.ed25519))
      else
        muxed_xdr = muxed_xdr.med25519!
        new(KeyPair.from_public_key(muxed_xdr.ed25519), muxed_xdr.id)
      end
    end

    def self.master
      keypair = Stellar::KeyPair.from_raw_seed("allmylifemyhearthasbeensearching")
      new(keypair)
    end

    attr_reader :keypair, :id

    # @param [Stellar::KeyPair] keypair
    # @param [Integer] id
    def initialize(keypair, id = nil)
      @keypair = keypair
      @id = id
    end

    def account_id
      Stellar::AccountID.ed25519(keypair.raw_public_key)
    end

    def base_account
      Stellar::MuxedAccount.ed25519(keypair.raw_public_key)
    end

    def muxed_account
      return base_account unless id
      Stellar::MuxedAccount.med25519(ed25519: keypair.raw_public_key, id: id)
    end

    def address(force_account_id: true)
      return keypair.address if force_account_id

      Util::StrKey.check_encode(:muxed, keypair.raw_public_key + [id].pack("Q>"))
    end

    def to_keypair
      keypair
    end

    def ==(other)
      other.is_a?(Account) && other.keypair == keypair && other.id == id
    end

    def hash
      [keypair, id].hash
    end
  end
end
