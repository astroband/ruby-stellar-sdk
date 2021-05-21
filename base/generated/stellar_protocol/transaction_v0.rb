# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionV0
#   {
#       uint256 sourceAccountEd25519;
#       uint32 fee;
#       SequenceNumber seqNum;
#       TimeBounds* timeBounds;
#       Memo memo;
#       Operation operations<MAX_OPS_PER_TX>;
#       union switch (int v)
#       {
#       case 0:
#           void;
#       }
#       ext;
#   };
#
# ===========================================================================
module StellarProtocol
  class TransactionV0 < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :source_account_ed25519, Uint256
    attribute :fee,                    Uint32
    attribute :seq_num,                SequenceNumber
    attribute :time_bounds,            XDR::Option[TimeBounds]
    attribute :memo,                   Memo
    attribute :operations,             XDR::VarArray[Operation, MAX_OPS_PER_TX]
    attribute :ext,                    Ext
  end
end
