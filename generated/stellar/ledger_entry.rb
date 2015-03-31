# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union LedgerEntry switch (LedgerEntryType type)
#   {
#   case ACCOUNT:
#       AccountEntry account;
#   
#   case TRUSTLINE:
#       TrustLineEntry trustLine;
#   
#   case OFFER:
#       OfferEntry offer;
#   };
#
# ===========================================================================
module Stellar
  class LedgerEntry < XDR::Union
    switch_on LedgerEntryType, :type

    switch :account,   :account
    switch :trustline, :trust_line
    switch :offer,     :offer

    attribute :account,    AccountEntry
    attribute :trust_line, TrustLineEntry
    attribute :offer,      OfferEntry
  end
end
