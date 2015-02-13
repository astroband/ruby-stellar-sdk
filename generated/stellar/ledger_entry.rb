# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class LedgerEntry < XDR::Union


    switch_on LedgerEntryType, :type
                                      
    switch LedgerEntryType.account,   :account
    switch LedgerEntryType.trustline, :trust_line
    switch LedgerEntryType.offer,     :offer
                           
    attribute :account,    AccountEntry
    attribute :trust_line, TrustLineEntry
    attribute :offer,      OfferEntry
  end
end
