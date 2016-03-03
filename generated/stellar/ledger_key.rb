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
#           uint64 offerID;
#       } offer;
#   
#   case DATA:
#       struct
#       {
#           AccountID accountID;
#           string64 dataName;
#       } data;
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

    switch_on LedgerEntryType, :type

    switch :account,   :account
    switch :trustline, :trust_line
    switch :offer,     :offer
    switch :data,      :data

    attribute :account,    Account
    attribute :trust_line, TrustLine
    attribute :offer,      Offer
    attribute :data,       Data
  end
end
