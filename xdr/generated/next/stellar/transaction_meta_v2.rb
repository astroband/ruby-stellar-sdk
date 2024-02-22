# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionMetaV2
#   {
#       LedgerEntryChanges txChangesBefore; // tx level changes before operations
#                                           // are applied if any
#       OperationMeta operations<>;         // meta for each operation
#       LedgerEntryChanges txChangesAfter;  // tx level changes after operations are
#                                           // applied if any
#   };
#
# ===========================================================================
module Stellar
  class TransactionMetaV2 < XDR::Struct
    attribute :tx_changes_before, LedgerEntryChanges
    attribute :operations,        XDR::VarArray[OperationMeta]
    attribute :tx_changes_after,  LedgerEntryChanges
  end
end
