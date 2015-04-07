# Automatically generated on 2015-04-07T10:52:07-07:00
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
#           Currency currency;
#       } trustLine;
#   
#   case OFFER:
#       struct
#       {
#           AccountID accountID;
#           uint64 offerID;
#       } offer;
#   };
#
# ===========================================================================
module Stellar
  class LedgerKey < XDR::Union
    include XDR::Namespace

    autoload :Account
    autoload :TrustLine
    autoload :Offer

    switch_on LedgerEntryType, :type

    switch :account,   :account
    switch :trustline, :trust_line
    switch :offer,     :offer

    attribute :account,    Account
    attribute :trust_line, TrustLine
    attribute :offer,      Offer
  end
end
