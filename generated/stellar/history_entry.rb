# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class HistoryEntry < XDR::Struct

                       
    attribute :header, LedgerHeader
    attribute :tx_set, TransactionSet
  end
end
