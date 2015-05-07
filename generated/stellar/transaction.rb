# Automatically generated on 2015-05-07T07:56:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct Transaction
#   {
#       // account used to run the transaction
#       AccountID sourceAccount;
#   
#       // maximum fee this transaction can collect
#       // the transaction is aborted if the fee is higher
#       int32 maxFee;
#   
#       // sequence number to consume in the account
#       SequenceNumber seqNum;
#   
#       // validity range (inclusive) for the ledger sequence number
#       uint32 minLedger;
#       uint32 maxLedger;
#   
#   	Memo memo;
#   
#       Operation operations<100>;
#   };
#
# ===========================================================================
module Stellar
  class Transaction < XDR::Struct
    attribute :source_account, AccountID
    attribute :max_fee,        Int32
    attribute :seq_num,        SequenceNumber
    attribute :min_ledger,     Uint32
    attribute :max_ledger,     Uint32
    attribute :memo,           Memo
    attribute :operations,     XDR::VarArray[Operation, 100]
  end
end
