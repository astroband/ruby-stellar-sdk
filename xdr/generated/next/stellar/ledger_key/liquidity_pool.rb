# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           PoolID liquidityPoolID;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class LiquidityPool < XDR::Struct
      attribute :liquidity_pool_id, PoolID
    end
  end
end
