# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct OperationMeta
#   {
#       LedgerEntryChanges changes;
#   };
#
# ===========================================================================
module StellarProtocol
  class OperationMeta < XDR::Struct
    attribute :changes, LedgerEntryChanges
  end
end
