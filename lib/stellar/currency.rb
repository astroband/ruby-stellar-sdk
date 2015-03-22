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

    def to_s
      if switch == CurrencyType.native
        "native"
      else
        encoder = Stellar::Util::Base58.stellar
        issuer_address = encoder.check_encode(:account_id,iso_ci.issuer)
        "#{iso_ci.currency_code}/#{issuer_address}"
      end
    end

    def inspect
      label = switch.to_s
      "#<Stellar::Currency #{to_s}>"
    end
  end
end