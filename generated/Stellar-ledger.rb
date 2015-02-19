# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  autoload :CLFBucketHeader, "#{File.dirname(__FILE__)}/stellar/clf_bucket_header"
  autoload :CLFLevel, "#{File.dirname(__FILE__)}/stellar/clf_level"
  autoload :LedgerHeader, "#{File.dirname(__FILE__)}/stellar/ledger_header"

  autoload :CLFType, "#{File.dirname(__FILE__)}/stellar/clf_type"

  autoload :LedgerKey, "#{File.dirname(__FILE__)}/stellar/ledger_key"

  autoload :CLFEntry, "#{File.dirname(__FILE__)}/stellar/clf_entry"
  autoload :CLFBucket, "#{File.dirname(__FILE__)}/stellar/clf_bucket"
  autoload :TransactionSet, "#{File.dirname(__FILE__)}/stellar/transaction_set"
  autoload :HistoryEntry, "#{File.dirname(__FILE__)}/stellar/history_entry"
  autoload :History, "#{File.dirname(__FILE__)}/stellar/history"
end
