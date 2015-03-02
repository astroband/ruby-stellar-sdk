# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  autoload :LedgerEntryType, "#{File.dirname(__FILE__)}/stellar/ledger_entry_type"

  autoload :Signer, "#{File.dirname(__FILE__)}/stellar/signer"
  autoload :KeyValue, "#{File.dirname(__FILE__)}/stellar/key_value"

  autoload :AccountFlags, "#{File.dirname(__FILE__)}/stellar/account_flags"

  autoload :AccountEntry, "#{File.dirname(__FILE__)}/stellar/account_entry"
  autoload :TrustLineEntry, "#{File.dirname(__FILE__)}/stellar/trust_line_entry"
  autoload :OfferEntry, "#{File.dirname(__FILE__)}/stellar/offer_entry"

  autoload :LedgerEntry, "#{File.dirname(__FILE__)}/stellar/ledger_entry"
end
