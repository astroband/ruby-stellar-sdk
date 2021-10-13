module Stellar
  module LiquidityPool
    class BasePool
      attr_reader :asset_a, :asset_b, :fee

      # @param asset_a [Asset]
      # @param asset_b [Asset]
      def initialize(asset_a:, asset_b:)
        @asset_a = asset_a
        @asset_b = asset_b
        @fee = LIQUIDITY_POOL_FEE_V18
      end

      def id
        PoolID.to_xdr(to_pool_id, :hex)
      end

      def to_s
        "liquidity_pool:#{id}"
      end

      def inspect
        "#<#{self.class.name} #{self}>"
      end

      def to_pool_id
        Digest::SHA256.digest(pool_params.to_xdr)
      end

      def to_change_trust_asset
        ChangeTrustAsset.liquidity_pool(pool_params)
      end

      def to_trust_line_asset
        TrustLineAsset.liquidity_pool_id(to_pool_id)
      end

      def pool_type
        raise NotImplementedError
      end

      def pool_params
        raise NotImplementedError
      end
    end
  end
end
