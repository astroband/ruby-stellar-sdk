# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (LedgerEntryType type)
#       {
#       case ACCOUNT:
#           AccountEntry account;
#       case TRUSTLINE:
#           TrustLineEntry trustLine;
#       case OFFER:
#           OfferEntry offer;
#       case DATA:
#           DataEntry data;
#       case CLAIMABLE_BALANCE:
#           ClaimableBalanceEntry claimableBalance;
#       case LIQUIDITY_POOL:
#           LiquidityPoolEntry liquidityPool;
#       }
#
# ===========================================================================
module Stellar
  class LedgerEntry
    class Data < XDR::Union
      switch_on LedgerEntryType, :type

      switch :account,           :account
      switch :trustline,         :trust_line
      switch :offer,             :offer
      switch :data,              :data
      switch :claimable_balance, :claimable_balance
      switch :liquidity_pool,    :liquidity_pool

      attribute :account,           AccountEntry
      attribute :trust_line,        TrustLineEntry
      attribute :offer,             OfferEntry
      attribute :data,              DataEntry
      attribute :claimable_balance, ClaimableBalanceEntry
      attribute :liquidity_pool,    LiquidityPoolEntry
    end
  end
end
