# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union LedgerKey switch (LedgerEntryType type)
#   {
#   case ACCOUNT:
#       struct
#       {
#           AccountID accountID;
#       } account;
#   
#   case TRUSTLINE:
#       struct
#       {
#           AccountID accountID;
#           TrustLineAsset asset;
#       } trustLine;
#   
#   case OFFER:
#       struct
#       {
#           AccountID sellerID;
#           int64 offerID;
#       } offer;
#   
#   case DATA:
#       struct
#       {
#           AccountID accountID;
#           string64 dataName;
#       } data;
#   
#   case CLAIMABLE_BALANCE:
#       struct
#       {
#           ClaimableBalanceID balanceID;
#       } claimableBalance;
#   
#   case LIQUIDITY_POOL:
#       struct
#       {
#           PoolID liquidityPoolID;
#       } liquidityPool;
#   case CONTRACT_DATA:
#       struct
#       {
#           SCAddress contract;
#           SCVal key;
#           ContractDataDurability durability;
#       } contractData;
#   case CONTRACT_CODE:
#       struct
#       {
#           Hash hash;
#       } contractCode;
#   case CONFIG_SETTING:
#       struct
#       {
#           ConfigSettingID configSettingID;
#       } configSetting;
#   case EXPIRATION:
#       struct
#       {
#           // Hash of the LedgerKey that is associated with this ExpirationEntry
#           Hash keyHash;
#       } expiration;
#   };
#
# ===========================================================================
module Stellar
  class LedgerKey < XDR::Union
    include XDR::Namespace

    autoload :Account
    autoload :TrustLine
    autoload :Offer
    autoload :Data
    autoload :ClaimableBalance
    autoload :LiquidityPool
    autoload :ContractData
    autoload :ContractCode
    autoload :ConfigSetting
    autoload :Expiration

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
    switch :expiration,        :expiration

    attribute :account,           Account
    attribute :trust_line,        TrustLine
    attribute :offer,             Offer
    attribute :data,              Data
    attribute :claimable_balance, ClaimableBalance
    attribute :liquidity_pool,    LiquidityPool
    attribute :contract_data,     ContractData
    attribute :contract_code,     ContractCode
    attribute :config_setting,    ConfigSetting
    attribute :expiration,        Expiration
  end
end
