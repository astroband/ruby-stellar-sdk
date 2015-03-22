module Stellar
  class Amount
    include Contracts

    attr_reader :amount
    attr_reader :currency

    Contract Pos, Currency => Any
    def initialize(amount, currency=Stellar::Currency.native())
      # TODO: how are we going to handle decimal considerations?
      
      @amount   = amount
      @currency = currency
    end


    Contract None => Or[
      [:iso4217, String, KeyPair, Pos],
      [:native, Pos],
    ]
    def to_payment
      case currency.type 
      when CurrencyType.native
        [:native, amount]
      when CurrencyType.iso4217
        keypair = KeyPair.from_public_key(currency.issuer)
        [:iso4217, currency, keypair, amount]
      else
        raise "Unknown currency type: #{currency.type}"
      end
    end

    def inspect
      "#<Stellar::Amount #{currency}(#{amount})>" 
    end
  end
end