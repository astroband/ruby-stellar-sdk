# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionHistoryResultEntry < XDR::Struct
    attribute :ledger_seq,    Uint32
    attribute :tx_result_set, TransactionResultSet
  end
end
