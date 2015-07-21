module Stellar
  class Asset
    def self.native
      new(:asset_type_native)
    end

    def self.alphanum4(code, issuer)
      raise ArgumentError, "Bad :issuer" unless issuer.is_a?(KeyPair)
      code = normalize_code(code)
      an = AlphaNum4.new({asset_code:code, issuer:issuer.account_id})
      new(:asset_type_credit_alphanum4, an)
    end

    def to_s
      if switch == AssetType.asset_type_native
        "native"
      else
        issuer_address = Stellar::Util::StrKey.check_encode(:account_id,alpha_num.issuer)
        "#{alpha_num.asset_code}/#{issuer_address}"
      end
    end

    def inspect
      label = switch.to_s
      "#<Stellar::Asset #{to_s}>"
    end

    def code
      self.alpha_num!.asset_code
    end

    def self.normalize_code(code)
      raise ArgumentError, "Invalid asset code: #{code}, must be <= 4 bytes" if code.length > 4

      code.ljust(4, "\x00")
    end
  end
end
