# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionHistoryResultEntry
#   {
#       uint32 ledgerSeq;
#       TransactionResultSet txResultSet;
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
  class TransactionHistoryResultEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :ledger_seq,    Uint32
    attribute :tx_result_set, TransactionResultSet
    attribute :ext,           Ext
  end
end
