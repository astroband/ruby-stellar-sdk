# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class LedgerKey < XDR::Union
    autoload :Account,   "#{__dir__}/ledger_key/account"
    autoload :TrustLine, "#{__dir__}/ledger_key/trust_line"
    autoload :Offer,     "#{__dir__}/ledger_key/offer"

    switch_on LedgerEntryType, :type
                                      
    switch LedgerEntryType.account,   :account
    switch LedgerEntryType.trustline, :trust_line
    switch LedgerEntryType.offer,     :offer
                           
    attribute :account,    Account
    attribute :trust_line, TrustLine
    attribute :offer,      Offer
  end
end
