# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum LedgerHeaderFlags
#   {
#       DISABLE_LIQUIDITY_POOL_TRADING_FLAG = 0x1,
#       DISABLE_LIQUIDITY_POOL_DEPOSIT_FLAG = 0x2,
#       DISABLE_LIQUIDITY_POOL_WITHDRAWAL_FLAG = 0x4
#   };
#
# ===========================================================================
module Stellar
  class LedgerHeaderFlags < XDR::Enum
    member :disable_liquidity_pool_trading_flag,    1
    member :disable_liquidity_pool_deposit_flag,    2
    member :disable_liquidity_pool_withdrawal_flag, 4

    seal
  end
end
