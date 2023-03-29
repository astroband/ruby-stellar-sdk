# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LiquidityPoolDepositOp
#   {
#       PoolID liquidityPoolID;
#       int64 maxAmountA; // maximum amount of first asset to deposit
#       int64 maxAmountB; // maximum amount of second asset to deposit
#       Price minPrice;   // minimum depositA/depositB
#       Price maxPrice;   // maximum depositA/depositB
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolDepositOp < XDR::Struct
    attribute :liquidity_pool_id, PoolID
    attribute :max_amount_a,      Int64
    attribute :max_amount_b,      Int64
    attribute :min_price,         Price
    attribute :max_price,         Price
  end
end
