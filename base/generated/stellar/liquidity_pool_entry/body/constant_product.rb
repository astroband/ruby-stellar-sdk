# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#           {
#               LiquidityPoolConstantProductParameters params;
#   
#               int64 reserveA;        // amount of A in the pool
#               int64 reserveB;        // amount of B in the pool
#               int64 totalPoolShares; // total number of pool shares issued
#               int64 poolSharesTrustLineCount; // number of trust lines for the associated pool shares
#           }
#
# ===========================================================================
module Stellar
  class LiquidityPoolEntry
    class Body
      class ConstantProduct < XDR::Struct
        attribute :params,                       LiquidityPoolConstantProductParameters
        attribute :reserve_a,                    Int64
        attribute :reserve_b,                    Int64
        attribute :total_pool_shares,            Int64
        attribute :pool_shares_trust_line_count, Int64
      end
    end
  end
end
