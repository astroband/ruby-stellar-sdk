# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

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
