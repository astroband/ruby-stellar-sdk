# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  autoload :CLFBucketHeader, "#{__dir__}/stellar/clf_bucket_header"
  autoload :CLFLevel, "#{__dir__}/stellar/clf_level"
  autoload :LedgerHeader, "#{__dir__}/stellar/ledger_header"

  autoload :CLFType, "#{__dir__}/stellar/clf_type"

  autoload :LedgerKey, "#{__dir__}/stellar/ledger_key"

  autoload :CLFEntry, "#{__dir__}/stellar/clf_entry"
  autoload :CLFBucket, "#{__dir__}/stellar/clf_bucket"
  autoload :TransactionSet, "#{__dir__}/stellar/transaction_set"
  autoload :HistoryEntry, "#{__dir__}/stellar/history_entry"
  autoload :History, "#{__dir__}/stellar/history"
end
