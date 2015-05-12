# Automatically generated on 2015-05-12T13:13:19-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct Transaction
#   {
#       // account used to run the transaction
#       AccountID sourceAccount;
#   
#       // the fee the sourceAccount will pay 
#       int32 fee;
#   
#       // sequence number to consume in the account
#       SequenceNumber seqNum;
#   
#       // validity range (inclusive) for the ledger sequence number
#       uint32 minLedger;
#       uint32 maxLedger;
#   
#       Memo memo;
#   
#       Operation operations<100>;
#   };
#
# ===========================================================================
module Stellar
  class Transaction < XDR::Struct
    attribute :source_account, AccountID
    attribute :fee,            Int32
    attribute :seq_num,        SequenceNumber
    attribute :min_ledger,     Uint32
    attribute :max_ledger,     Uint32
    attribute :memo,           Memo
    attribute :operations,     XDR::VarArray[Operation, 100]
  end
end
