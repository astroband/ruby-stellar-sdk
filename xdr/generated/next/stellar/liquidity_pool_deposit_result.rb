# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union LiquidityPoolDepositResult switch (LiquidityPoolDepositResultCode code)
#   {
#   case LIQUIDITY_POOL_DEPOSIT_SUCCESS:
#       void;
#   case LIQUIDITY_POOL_DEPOSIT_MALFORMED:
#   case LIQUIDITY_POOL_DEPOSIT_NO_TRUST:
#   case LIQUIDITY_POOL_DEPOSIT_NOT_AUTHORIZED:
#   case LIQUIDITY_POOL_DEPOSIT_UNDERFUNDED:
#   case LIQUIDITY_POOL_DEPOSIT_LINE_FULL:
#   case LIQUIDITY_POOL_DEPOSIT_BAD_PRICE:
#   case LIQUIDITY_POOL_DEPOSIT_POOL_FULL:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolDepositResult < XDR::Union
    switch_on LiquidityPoolDepositResultCode, :code

    switch :liquidity_pool_deposit_success
    switch :liquidity_pool_deposit_malformed
    switch :liquidity_pool_deposit_no_trust
    switch :liquidity_pool_deposit_not_authorized
    switch :liquidity_pool_deposit_underfunded
    switch :liquidity_pool_deposit_line_full
    switch :liquidity_pool_deposit_bad_price
    switch :liquidity_pool_deposit_pool_full

  end
end
