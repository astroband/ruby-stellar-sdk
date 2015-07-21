# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           LedgerEntryChanges changes;
#           OperationMeta operations<>;
#       }
#
# ===========================================================================
module Stellar
  class TransactionMeta
    class V0 < XDR::Struct
      attribute :changes,    LedgerEntryChanges
      attribute :operations, XDR::VarArray[OperationMeta]
    end
  end
end
