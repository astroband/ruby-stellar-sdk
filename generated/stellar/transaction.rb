# This code was automatically generated using xdrgen
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
#       uint32 fee;
#   
#       // sequence number to consume in the account
#       SequenceNumber seqNum;
#   
#       // validity range (inclusive) for the last ledger close time
#       TimeBounds* timeBounds;
#   
#       Memo memo;
#   
#       Operation operations<MAX_OPS_PER_TX>;
#   
#       // reserved for future use
#       union switch (int v)
#       {
#       case 0:
#           void;
#       }
#       ext;
#   };
#
# ===========================================================================
module Stellar
  class Transaction < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :source_account, AccountID
    attribute :fee,            Uint32
    attribute :seq_num,        SequenceNumber
    attribute :time_bounds,    XDR::Option[TimeBounds]
    attribute :memo,           Memo
    attribute :operations,     XDR::VarArray[Operation, MAX_OPS_PER_TX]
    attribute :ext,            Ext
  end
end
