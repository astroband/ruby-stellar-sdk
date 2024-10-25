# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union LiquidityPoolWithdrawResult switch (LiquidityPoolWithdrawResultCode code)
#   {
#   case LIQUIDITY_POOL_WITHDRAW_SUCCESS:
#       void;
#   case LIQUIDITY_POOL_WITHDRAW_MALFORMED:
#   case LIQUIDITY_POOL_WITHDRAW_NO_TRUST:
#   case LIQUIDITY_POOL_WITHDRAW_UNDERFUNDED:
#   case LIQUIDITY_POOL_WITHDRAW_LINE_FULL:
#   case LIQUIDITY_POOL_WITHDRAW_UNDER_MINIMUM:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolWithdrawResult < XDR::Union
    switch_on LiquidityPoolWithdrawResultCode, :code

    switch :liquidity_pool_withdraw_success
    switch :liquidity_pool_withdraw_malformed
    switch :liquidity_pool_withdraw_no_trust
    switch :liquidity_pool_withdraw_underfunded
    switch :liquidity_pool_withdraw_line_full
    switch :liquidity_pool_withdraw_under_minimum

  end
end
