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
#       case CONTRACT_DATA:
#           ContractDataEntry contractData;
#       case CONTRACT_CODE:
#           ContractCodeEntry contractCode;
#       case CONFIG_SETTING:
#           ConfigSettingEntry configSetting;
#       case TTL:
#           TTLEntry ttl;
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
      switch :contract_data,     :contract_data
      switch :contract_code,     :contract_code
      switch :config_setting,    :config_setting
      switch :ttl,               :ttl

      attribute :account,           AccountEntry
      attribute :trust_line,        TrustLineEntry
      attribute :offer,             OfferEntry
      attribute :data,              DataEntry
      attribute :claimable_balance, ClaimableBalanceEntry
      attribute :liquidity_pool,    LiquidityPoolEntry
      attribute :contract_data,     ContractDataEntry
      attribute :contract_code,     ContractCodeEntry
      attribute :config_setting,    ConfigSettingEntry
      attribute :ttl,               TTLEntry
    end
  end
end
