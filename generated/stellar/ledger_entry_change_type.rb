# Automatically generated on 2015-05-14T08:36:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum LedgerEntryChangeType
#   {
#       LEDGER_ENTRY_CREATED = 0, // entry was added to the ledger
#       LEDGER_ENTRY_UPDATED = 1, // entry was modified in the ledger
#       LEDGER_ENTRY_REMOVED = 2  // entry was removed from the ledger
#   };
#
# ===========================================================================
module Stellar
  class LedgerEntryChangeType < XDR::Enum
    member :ledger_entry_created, 0
    member :ledger_entry_updated, 1
    member :ledger_entry_removed, 2

    seal
  end
end
