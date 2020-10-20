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
#           Asset asset;
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

    switch_on LedgerEntryType, :type

    switch :account,           :account
    switch :trustline,         :trust_line
    switch :offer,             :offer
    switch :data,              :data
    switch :claimable_balance, :claimable_balance

    attribute :account,           Account
    attribute :trust_line,        TrustLine
    attribute :offer,             Offer
    attribute :data,              Data
    attribute :claimable_balance, ClaimableBalance
  end
end
