# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LiquidityPoolEntry
#   {
#       PoolID liquidityPoolID;
#   
#       union switch (LiquidityPoolType type)
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
#       body;
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolEntry < XDR::Struct
    include XDR::Namespace

    autoload :Body

    attribute :liquidity_pool_id, PoolID
    attribute :body,              Body
  end
end
