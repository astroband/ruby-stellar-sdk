module Stellar
  Currency.class_eval do
    def self.native
      new(:native)
    end

    def self.iso4217(code, issuer)
      raise ArgumentError, "Bad :issuer" unless issuer.is_a?(KeyPair)
      ici = ISOCurrencyIssuer.new({currency_code:code, issuer:issuer.public_key})
      new(:iso4217, ici)
    end
  end
end