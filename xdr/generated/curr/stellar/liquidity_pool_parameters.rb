# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union LiquidityPoolParameters switch (LiquidityPoolType type)
#   {
#   case LIQUIDITY_POOL_CONSTANT_PRODUCT:
#       LiquidityPoolConstantProductParameters constantProduct;
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolParameters < XDR::Union
    switch_on LiquidityPoolType, :type

    switch :liquidity_pool_constant_product, :constant_product

    attribute :constant_product, LiquidityPoolConstantProductParameters
  end
end
