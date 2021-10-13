# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum LedgerEntryType
#   {
#       ACCOUNT = 0,
#       TRUSTLINE = 1,
#       OFFER = 2,
#       DATA = 3,
#       CLAIMABLE_BALANCE = 4,
#       LIQUIDITY_POOL = 5
#   };
#
# ===========================================================================
module Stellar
  class LedgerEntryType < XDR::Enum
    member :account,           0
    member :trustline,         1
    member :offer,             2
    member :data,              3
    member :claimable_balance, 4
    member :liquidity_pool,    5

    seal
  end
end
