# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionMetaV3
#   {
#       LedgerEntryChanges txChangesBefore; // tx level changes before operations
#                                           // are applied if any
#       OperationMeta operations<>;         // meta for each operation
#       LedgerEntryChanges txChangesAfter;  // tx level changes after operations are
#                                           // applied if any
#       OperationEvents events<>;           // custom events populated by the
#                                           // contracts themselves. One list per operation.
#       TransactionResult txResult;
#   
#       Hash hashes[3];                     // stores sha256(txChangesBefore, operations, txChangesAfter),
#                                           // sha256(events), and sha256(txResult)
#   
#       // Diagnostics events that are not hashed. One list per operation.
#       // This will contain all contract and diagnostic events. Even ones
#       // that were emitted in a failed contract call.
#       OperationDiagnosticEvents diagnosticEvents<>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionMetaV3 < XDR::Struct
    attribute :tx_changes_before, LedgerEntryChanges
    attribute :operations,        XDR::VarArray[OperationMeta]
    attribute :tx_changes_after,  LedgerEntryChanges
    attribute :events,            XDR::VarArray[OperationEvents]
    attribute :tx_result,         TransactionResult
    attribute :hashes,            XDR::Array[Hash, 3]
    attribute :diagnostic_events, XDR::VarArray[OperationDiagnosticEvents]
  end
end
