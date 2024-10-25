# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionHistoryResultEntryV2
#   {
#       uint32 ledgerSeq;
#       TransactionResultSetV2 txResultSet;
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
  class TransactionHistoryResultEntryV2 < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :ledger_seq,    Uint32
    attribute :tx_result_set, TransactionResultSetV2
    attribute :ext,           Ext
  end
end
