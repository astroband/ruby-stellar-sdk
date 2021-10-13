# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LiquidityPoolWithdrawOp
#   {
#       PoolID liquidityPoolID;
#       int64 amount;         // amount of pool shares to withdraw
#       int64 minAmountA;     // minimum amount of first asset to withdraw
#       int64 minAmountB;     // minimum amount of second asset to withdraw
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolWithdrawOp < XDR::Struct
    attribute :liquidity_pool_id, PoolID
    attribute :amount,            Int64
    attribute :min_amount_a,      Int64
    attribute :min_amount_b,      Int64
  end
end
