module Stellar
  class Asset
    TYPES = %i[native alphanum4 alphanum12]

    def self.native
      new(:asset_type_native)
    end

    # @param code   [String] asset code
    # @param issuer [#to_keypair] asset issuer
    #
    # @return [Stellar::Asset::AlphaNum4] asset4 representation
    def self.alphanum4(code, issuer)
      an = AlphaNum4.new({
        asset_code: normalize_code(code, 4),
        issuer: normalize_issuer(issuer)
      })

      new(:asset_type_credit_alphanum4, an)
    end

    # @param code   [String] asset code
    # @param issuer [#to_keypair] asset issuer
    #
    # @return [Stellar::Asset::AlphaNum4] asset4 representation
    def self.alphanum12(code, issuer)
      an = AlphaNum12.new({
        asset_code: normalize_code(code, 12),
        issuer: normalize_issuer(issuer)
      })

      new(:asset_type_credit_alphanum12, an)
    end

    def to_change_trust_asset
      ChangeTrustAsset.new(switch, value)
    end

    def to_trust_line_asset
      TrustLineAsset.new(switch, value)
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
      # label = switch.to_s
      "#<Stellar::Asset #{self}>"
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

    def self.normalize_issuer(issuer)
      issuer = issuer.account_id if issuer.respond_to?(:account_id)
      return issuer if issuer.is_a?(AccountID)

      raise ArgumentError, "bad issuer '#{issuer.inspect}'"
    end
  end
end
