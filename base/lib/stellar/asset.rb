module Stellar
  class Asset
    TYPES = %i(native alphanum4 alphanum12)

    def self.native
      new(:asset_type_native)
    end

    def self.alphanum4(code, issuer)
      raise ArgumentError, "Bad :issuer" unless issuer.is_a?(KeyPair)
      code = normalize_code(code, 4)
      an = AlphaNum4.new({asset_code:code, issuer:issuer.account_id})
      new(:asset_type_credit_alphanum4, an)
    end

    def self.alphanum12(code, issuer)
      raise ArgumentError, "Bad :issuer" unless issuer.is_a?(KeyPair)
      code = normalize_code(code, 12)
      an = AlphaNum12.new({asset_code:code, issuer:issuer.account_id})
      new(:asset_type_credit_alphanum12, an)
    end

    def to_s
      case switch
      when AssetType.asset_type_native
        "native"
      when AssetType.asset_type_credit_alphanum4
        anum = alpha_num4!
        issuer_address = Stellar::Convert.pk_to_address(anum.issuer)
        "#{anum.asset_code}/#{issuer_address}"
      when AssetType.asset_type_credit_alphanum12
        anum = alpha_num12!
        issuer_address = Stellar::Convert.pk_to_address(anum.issuer)
        "#{anum.asset_code}/#{issuer_address}"
      end
    end

    def inspect
      label = switch.to_s
      "#<Stellar::Asset #{to_s}>"
    end

    def code
      case switch
      when AssetType.asset_type_credit_alphanum4
        alpha_num4!.asset_code
      when AssetType.asset_type_credit_alphanum12
        alpha_num12!.asset_code
      else
        raise "#{switch} assets do not have a code"
      end
    end
    
    def issuer
      case switch
      when AssetType.asset_type_credit_alphanum4
        alpha_num4!.issuer
      when AssetType.asset_type_credit_alphanum12
        alpha_num12!.issuer
      else
        raise "#{switch} assets do not have a isuuer"
      end
    end

    def self.normalize_code(code, length)
      raise ArgumentError, "Invalid asset code: #{code}, must be <= #{length} bytes" if code.length > length

      code.ljust(length, "\x00")
    end
  end
end
