# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LiquidityPoolConstantProductParameters
#   {
#       Asset assetA; // assetA < assetB
#       Asset assetB;
#       int32 fee;    // Fee is in basis points, so the actual rate is (fee/100)%
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolConstantProductParameters < XDR::Struct
    attribute :asset_a, Asset
    attribute :asset_b, Asset
    attribute :fee,     Int32
  end
end
