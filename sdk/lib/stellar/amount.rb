module Stellar
  class Amount
    attr_reader :amount
    attr_reader :asset

    # @param [Fixnum] amount
    # @param [Stellar::Asset] asset
    def initialize(amount, asset=Stellar::Asset.native())
      # TODO: how are we going to handle decimal considerations?

      @amount = amount
      @asset  = asset
    end

    # @return [Array(Symbol, Fixnum)] in case of a native asset
    # @return [Array(Symbol, String, Stellar::KeyPair, Fixnum)] in case of alphanum asset
    def to_payment
      case asset.type
      when AssetType.asset_type_native
        [:native, amount]
      when AssetType.asset_type_credit_alphanum4
        keypair = KeyPair.from_public_key(asset.issuer.value)
        [:alphanum4, asset.code, keypair, amount]
      when AssetType.asset_type_credit_alphanum12
        keypair = KeyPair.from_public_key(asset.issuer.value)
        [:alphanum12, asset.code, keypair, amount]
      else
        raise "Unknown asset type: #{asset.type}"
      end
    end

    def inspect
      "#<Stellar::Amount #{asset}(#{amount})>"
    end
  end
end
