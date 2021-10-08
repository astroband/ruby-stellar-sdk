# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union LiquidityPoolWithdrawResult switch (
#       LiquidityPoolWithdrawResultCode code)
#   {
#   case LIQUIDITY_POOL_WITHDRAW_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolWithdrawResult < XDR::Union
    switch_on LiquidityPoolWithdrawResultCode, :code

    switch :liquidity_pool_withdraw_success
    switch :default

  end
end
