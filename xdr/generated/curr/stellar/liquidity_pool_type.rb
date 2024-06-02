# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum LiquidityPoolType
#   {
#       LIQUIDITY_POOL_CONSTANT_PRODUCT = 0
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolType < XDR::Enum
    member :liquidity_pool_constant_product, 0

    seal
  end
end
