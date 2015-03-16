# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionHistoryResultEntry < XDR::Struct
    attribute :ledger_seq,    Uint32
    attribute :tx_result_set, TransactionResultSet
  end
end
