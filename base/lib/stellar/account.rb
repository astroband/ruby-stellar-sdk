module Stellar
  class Account
    delegate :address, to: :keypair

    def self.random
      keypair = Stellar::KeyPair.random
      new(keypair)
    end

    def self.from_seed(seed)
      keypair = Stellar::KeyPair.from_seed(seed)
      new(keypair)
    end

    def self.from_address(address)
      keypair = Stellar::KeyPair.from_address(address)
      new(keypair)
    end

    def self.master
      keypair = Stellar::KeyPair.from_raw_seed("allmylifemyhearthasbeensearching")
      new(keypair)
    end

    attr_reader :keypair

    # @param [Stellar::KeyPair] keypair
    def initialize(keypair)
      @keypair = keypair
    end

    def to_keypair
      keypair
    end
  end
end
