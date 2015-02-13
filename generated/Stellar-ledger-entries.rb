# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  autoload :LedgerEntryType, "#{__dir__}/stellar/ledger_entry_type"

  autoload :Signer, "#{__dir__}/stellar/signer"
  autoload :KeyValue, "#{__dir__}/stellar/key_value"

  autoload :AccountFlag, "#{__dir__}/stellar/account_flags"

  autoload :AccountEntry, "#{__dir__}/stellar/account_entry"
  autoload :TrustLineEntry, "#{__dir__}/stellar/trust_line_entry"
  autoload :OfferEntry, "#{__dir__}/stellar/offer_entry"

  autoload :LedgerEntry, "#{__dir__}/stellar/ledger_entry"
end
