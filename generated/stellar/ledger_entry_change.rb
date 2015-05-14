# Automatically generated on 2015-05-14T08:36:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union LedgerEntryChange switch (LedgerEntryChangeType type)
#   {
#   case LEDGER_ENTRY_CREATED:
#       LedgerEntry created;
#   case LEDGER_ENTRY_UPDATED:
#       LedgerEntry updated;
#   case LEDGER_ENTRY_REMOVED:
#       LedgerKey removed;
#   };
#
# ===========================================================================
module Stellar
  class LedgerEntryChange < XDR::Union
    switch_on LedgerEntryChangeType, :type

    switch :ledger_entry_created, :created
    switch :ledger_entry_updated, :updated
    switch :ledger_entry_removed, :removed

    attribute :created, LedgerEntry
    attribute :updated, LedgerEntry
    attribute :removed, LedgerKey
  end
end
