# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class Transaction < XDR::Struct
    attribute :account,    AccountID
    attribute :max_fee,    Int32
    attribute :seq_num,    SequenceNumber
    attribute :min_ledger, Uint32
    attribute :max_ledger, Uint32
    attribute :operations, XDR::VarArray[Operation, 100]
  end
end
