# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionHistoryEntry
#   {
#       uint32 ledgerSeq;
#       TransactionSet txSet;
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
module StellarProtocol
  class TransactionHistoryEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :ledger_seq, Uint32
    attribute :tx_set,     TransactionSet
    attribute :ext,        Ext
  end
end
