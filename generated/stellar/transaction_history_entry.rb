# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionHistoryEntry < XDR::Struct
    attribute :ledger_seq, Uint64
    attribute :envelope,   TransactionEnvelope
    attribute :result,     TransactionResult
  end
end
