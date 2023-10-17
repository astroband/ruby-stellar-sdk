# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerCloseMetaV2
#   {
#       // We forgot to add an ExtensionPoint in v1 but at least
#       // we can add one now in v2.
#       ExtensionPoint ext;
#
#       LedgerHeaderHistoryEntry ledgerHeader;
#
#       GeneralizedTransactionSet txSet;
#
#       // NB: transactions are sorted in apply order here
#       // fees for all transactions are processed first
#       // followed by applying transactions
#       TransactionResultMeta txProcessing<>;
#
#       // upgrades are applied last
#       UpgradeEntryMeta upgradesProcessing<>;
#
#       // other misc information attached to the ledger close
#       SCPHistoryEntry scpInfo<>;
#
#       // Size in bytes of BucketList, to support downstream
#       // systems calculating storage fees correctly.
#       uint64 totalByteSizeOfBucketList;
#
#       // Expired temp keys that are being evicted at this ledger.
#       LedgerKey evictedTemporaryLedgerKeys<>;
#
#       // Expired restorable ledger entries that are being
#       // evicted at this ledger.
#       LedgerEntry evictedPersistentLedgerEntries<>;
#   };
#
# ===========================================================================
module Stellar
  class LedgerCloseMetaV2 < XDR::Struct
    attribute :ext,                               ExtensionPoint
    attribute :ledger_header,                     LedgerHeaderHistoryEntry
    attribute :tx_set,                            GeneralizedTransactionSet
    attribute :tx_processing,                     XDR::VarArray[TransactionResultMeta]
    attribute :upgrades_processing,               XDR::VarArray[UpgradeEntryMeta]
    attribute :scp_info,                          XDR::VarArray[SCPHistoryEntry]
    attribute :total_byte_size_of_bucket_list,    Uint64
    attribute :evicted_temporary_ledger_keys,     XDR::VarArray[LedgerKey]
    attribute :evicted_persistent_ledger_entries, XDR::VarArray[LedgerEntry]
  end
end
