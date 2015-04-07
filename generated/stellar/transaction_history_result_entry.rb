# Automatically generated on 2015-04-07T10:52:07-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionHistoryResultEntry
#   {
#       uint32 ledgerSeq;
#       TransactionResultSet txResultSet;
#   };
#
# ===========================================================================
module Stellar
  class TransactionHistoryResultEntry < XDR::Struct
    attribute :ledger_seq,    Uint32
    attribute :tx_result_set, TransactionResultSet
  end
end
