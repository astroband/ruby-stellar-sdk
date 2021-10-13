require_relative "base_pool"

module Stellar
  module LiquidityPool
    class ConstantProductPool < BasePool
      def pool_type
        LiquidityPoolType.constant_product
      end

      def pool_params
        LiquidityPoolParameters.constant_product(asset_a: asset_a, asset_b: asset_b, fee: fee)
      end
    end
  end
end
