# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum LiquidityPoolDepositResultCode
#   {
#       // codes considered as "success" for the operation
#       LIQUIDITY_POOL_DEPOSIT_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       LIQUIDITY_POOL_DEPOSIT_MALFORMED = -1,      // bad input
#       LIQUIDITY_POOL_DEPOSIT_NO_TRUST = -2,       // no trust line for one of the
#                                                   // assets
#       LIQUIDITY_POOL_DEPOSIT_NOT_AUTHORIZED = -3, // not authorized for one of the
#                                                   // assets
#       LIQUIDITY_POOL_DEPOSIT_UNDERFUNDED = -4,    // not enough balance for one of
#                                                   // the assets
#       LIQUIDITY_POOL_DEPOSIT_LINE_FULL = -5,      // pool share trust line doesn't
#                                                   // have sufficient limit
#       LIQUIDITY_POOL_DEPOSIT_BAD_PRICE = -6,      // deposit price outside bounds
#       LIQUIDITY_POOL_DEPOSIT_POOL_FULL = -7       // pool reserves are full
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolDepositResultCode < XDR::Enum
    member :liquidity_pool_deposit_success,        0
    member :liquidity_pool_deposit_malformed,      -1
    member :liquidity_pool_deposit_no_trust,       -2
    member :liquidity_pool_deposit_not_authorized, -3
    member :liquidity_pool_deposit_underfunded,    -4
    member :liquidity_pool_deposit_line_full,      -5
    member :liquidity_pool_deposit_bad_price,      -6
    member :liquidity_pool_deposit_pool_full,      -7

    seal
  end
end
