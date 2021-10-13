# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum LiquidityPoolWithdrawResultCode
#   {
#       // codes considered as "success" for the operation
#       LIQUIDITY_POOL_WITHDRAW_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       LIQUIDITY_POOL_WITHDRAW_MALFORMED = -1,      // bad input
#       LIQUIDITY_POOL_WITHDRAW_NO_TRUST = -2,       // no trust line for one of the
#                                                    // assets
#       LIQUIDITY_POOL_WITHDRAW_UNDERFUNDED = -3,    // not enough balance of the
#                                                    // pool share
#       LIQUIDITY_POOL_WITHDRAW_LINE_FULL = -4,      // would go above limit for one
#                                                    // of the assets
#       LIQUIDITY_POOL_WITHDRAW_UNDER_MINIMUM = -5   // didn't withdraw enough
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolWithdrawResultCode < XDR::Enum
    member :liquidity_pool_withdraw_success,       0
    member :liquidity_pool_withdraw_malformed,     -1
    member :liquidity_pool_withdraw_no_trust,      -2
    member :liquidity_pool_withdraw_underfunded,   -3
    member :liquidity_pool_withdraw_line_full,     -4
    member :liquidity_pool_withdraw_under_minimum, -5

    seal
  end
end
