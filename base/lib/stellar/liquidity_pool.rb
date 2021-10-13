module Stellar
  module LiquidityPool
    require_relative "liquidity_pool/base_pool"
    require_relative "liquidity_pool/constant_product_pool"

    module_function

    def constant_product(asset_a:, asset_b:)
      ConstantProductPool.new(asset_a: DSL::Asset(asset_a), asset_b: DSL::Asset(asset_b))
    end
  end
end
