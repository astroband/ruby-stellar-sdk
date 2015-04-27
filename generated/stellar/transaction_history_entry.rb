# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionHistoryEntry
#   {
#       uint32 ledgerSeq;
#       TransactionSet txSet;
#   };
#
# ===========================================================================
module Stellar
  class TransactionHistoryEntry < XDR::Struct
    attribute :ledger_seq, Uint32
    attribute :tx_set,     TransactionSet
  end
end
