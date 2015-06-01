module Stellar
  class Currency
    def self.native
      new(:currency_type_native)
    end

    def self.alphanum(code, issuer)
      raise ArgumentError, "Bad :issuer" unless issuer.is_a?(KeyPair)
      code = normalize_code(code)
      an = AlphaNum.new({currency_code:code, issuer:issuer.public_key})
      new(:currency_type_alphanum, an)
    end

    def to_s
      if switch == CurrencyType.currency_type_native
        "native"
      else
        encoder = Stellar::Util::Base58.stellar
        issuer_address = encoder.check_encode(:account_id,alpha_num.issuer)
        "#{alpha_num.currency_code}/#{issuer_address}"
      end
    end

    def inspect
      label = switch.to_s
      "#<Stellar::Currency #{to_s}>"
    end

    def code
      self.alpha_num!.currency_code
    end

    def self.normalize_code(code)
      raise ArgumentError, "Invalid currency code: #{code}, must be <= 4 bytes" if code.length > 4

      code.ljust(4, "\x00")
    end
  end
end
