# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ClaimLiquidityAtom
#   {
#       PoolID liquidityPoolID;
#   
#       // amount and asset taken from the pool
#       Asset assetSold;
#       int64 amountSold;
#   
#       // amount and asset sent to the pool
#       Asset assetBought;
#       int64 amountBought;
#   };
#
# ===========================================================================
module Stellar
  class ClaimLiquidityAtom < XDR::Struct
    attribute :liquidity_pool_id, PoolID
    attribute :asset_sold,        Asset
    attribute :amount_sold,       Int64
    attribute :asset_bought,      Asset
    attribute :amount_bought,     Int64
  end
end
