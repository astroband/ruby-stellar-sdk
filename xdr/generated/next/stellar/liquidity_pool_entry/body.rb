# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (LiquidityPoolType type)
#       {
#       case LIQUIDITY_POOL_CONSTANT_PRODUCT:
#           struct
#           {
#               LiquidityPoolConstantProductParameters params;
#   
#               int64 reserveA;        // amount of A in the pool
#               int64 reserveB;        // amount of B in the pool
#               int64 totalPoolShares; // total number of pool shares issued
#               int64 poolSharesTrustLineCount; // number of trust lines for the
#                                               // associated pool shares
#           } constantProduct;
#       }
#
# ===========================================================================
module Stellar
  class LiquidityPoolEntry
    class Body < XDR::Union
      include XDR::Namespace

      autoload :ConstantProduct

      switch_on LiquidityPoolType, :type

      switch :liquidity_pool_constant_product, :constant_product

      attribute :constant_product, ConstantProduct
    end
  end
end
