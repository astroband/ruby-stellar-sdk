# Automatically generated on 2015-05-14T08:36:04-07:00
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
