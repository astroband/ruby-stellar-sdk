# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionMeta
#   {
#       LedgerEntryChange changes<>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionMeta < XDR::Struct
    attribute :changes, XDR::VarArray[LedgerEntryChange]
  end
end
