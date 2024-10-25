# This code was automatically generated using xdrgen
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
#   case LEDGER_ENTRY_STATE:
#       LedgerEntry state;
#   };
#
# ===========================================================================
module Stellar
  class LedgerEntryChange < XDR::Union
    switch_on LedgerEntryChangeType, :type

    switch :ledger_entry_created, :created
    switch :ledger_entry_updated, :updated
    switch :ledger_entry_removed, :removed
    switch :ledger_entry_state,   :state

    attribute :created, LedgerEntry
    attribute :updated, LedgerEntry
    attribute :removed, LedgerKey
    attribute :state,   LedgerEntry
  end
end
