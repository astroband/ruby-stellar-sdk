module Stellar
  class Account
    include Contracts

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

    def self.lookup(federated_name)
      raise NotImplementedError
    end

    def self.master
      keypair = Stellar::KeyPair.from_raw_seed("allmylifemyhearthasbeensearching")
      new(keypair)
    end

    attr_reader :keypair

    Contract Stellar::KeyPair => Any
    def initialize(keypair)
      @keypair = keypair
    end
  end
end