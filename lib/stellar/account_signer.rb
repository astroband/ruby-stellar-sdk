module Stellar
  class AccountSigner
    include Contracts

    attr_reader :keypair
    attr_reader :weight

    Contract Array[String, Integer] => Any
    def initialize(address, weight = 0)
      @address = address
      @weight = weight
    end

    def ==(other)
      if !other.is_a(self.class)
        raise NotImplementedError.new
      end
      @address == other.address and @weight == other.weight
    end

    alias eql? ==

  end
end