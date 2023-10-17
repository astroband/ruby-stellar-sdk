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
#       // when v != 0, txSet must be empty
#       union switch (int v)
#       {
#       case 0:
#           void;
#       case 1:
#           GeneralizedTransactionSet generalizedTxSet;
#       }
#       ext;
#   };
#
# ===========================================================================
module Stellar
  class TransactionHistoryEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :ledger_seq, Uint32
    attribute :tx_set,     TransactionSet
    attribute :ext,        Ext
  end
end
