# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionMetaV3
#   {
#       ExtensionPoint ext;
#   
#       LedgerEntryChanges txChangesBefore;  // tx level changes before operations
#                                            // are applied if any
#       OperationMeta operations<>;          // meta for each operation
#       LedgerEntryChanges txChangesAfter;   // tx level changes after operations are
#                                            // applied if any
#       SorobanTransactionMeta* sorobanMeta; // Soroban-specific meta (only for 
#                                            // Soroban transactions).
#   };
#
# ===========================================================================
module Stellar
  class TransactionMetaV3 < XDR::Struct
    attribute :ext,               ExtensionPoint
    attribute :tx_changes_before, LedgerEntryChanges
    attribute :operations,        XDR::VarArray[OperationMeta]
    attribute :tx_changes_after,  LedgerEntryChanges
    attribute :soroban_meta,      XDR::Option[SorobanTransactionMeta]
  end
end
