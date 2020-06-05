# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionMetaV1
#   {
#       LedgerEntryChanges txChanges; // tx level changes if any
#       OperationMeta operations<>;   // meta for each operation
#   };
#
# ===========================================================================
module Stellar
  class TransactionMetaV1 < XDR::Struct
    attribute :tx_changes, LedgerEntryChanges
    attribute :operations, XDR::VarArray[OperationMeta]
  end
end
