module Stellar
  class Amount
    include Contracts

    attr_reader :amount
    attr_reader :asset

    Contract Pos, Asset => Any
    def initialize(amount, asset=Stellar::Asset.native())
      # TODO: how are we going to handle decimal considerations?
      
      @amount = amount
      @asset  = asset
    end


    Contract None => Or[
      [Or[:credit_alphanum4, :credit_alphanum12], String, KeyPair, Pos],
      [:native, Pos],
    ]
    def to_payment
      case asset.type 
      when AssetType.asset_type_native
        [:native, amount]
      when AssetType.asset_type_credit_alphanum4
        keypair = KeyPair.from_public_key(asset.issuer)
        [:credit_alphanum4, asset, keypair, amount]
      when AssetType.asset_type_credit_alphanum12
        keypair = KeyPair.from_public_key(asset.issuer)
        [:credit_alphanum12, asset, keypair, amount]
      else
        raise "Unknown asset type: #{asset.type}"
      end
    end

    def inspect
      "#<Stellar::Amount #{asset}(#{amount})>" 
    end
  end
end