# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ConfigSettingContractLedgerCostV0
#   {
#       // Maximum number of ledger entry read operations per ledger
#       uint32 ledgerMaxReadLedgerEntries;
#       // Maximum number of bytes that can be read per ledger
#       uint32 ledgerMaxReadBytes;
#       // Maximum number of ledger entry write operations per ledger
#       uint32 ledgerMaxWriteLedgerEntries;
#       // Maximum number of bytes that can be written per ledger
#       uint32 ledgerMaxWriteBytes;
#   
#       // Maximum number of ledger entry read operations per transaction
#       uint32 txMaxReadLedgerEntries;
#       // Maximum number of bytes that can be read per transaction
#       uint32 txMaxReadBytes;
#       // Maximum number of ledger entry write operations per transaction
#       uint32 txMaxWriteLedgerEntries;
#       // Maximum number of bytes that can be written per transaction
#       uint32 txMaxWriteBytes;
#   
#       int64 feeReadLedgerEntry;  // Fee per ledger entry read
#       int64 feeWriteLedgerEntry; // Fee per ledger entry write
#   
#       int64 feeRead1KB;  // Fee for reading 1KB
#   
#       // The following parameters determine the write fee per 1KB.
#       // Write fee grows linearly until bucket list reaches this size
#       int64 bucketListTargetSizeBytes;
#       // Fee per 1KB write when the bucket list is empty
#       int64 writeFee1KBBucketListLow;
#       // Fee per 1KB write when the bucket list has reached `bucketListTargetSizeBytes` 
#       int64 writeFee1KBBucketListHigh;
#       // Write fee multiplier for any additional data past the first `bucketListTargetSizeBytes`
#       uint32 bucketListWriteFeeGrowthFactor;
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingContractLedgerCostV0 < XDR::Struct
    attribute :ledger_max_read_ledger_entries,      Uint32
    attribute :ledger_max_read_bytes,               Uint32
    attribute :ledger_max_write_ledger_entries,     Uint32
    attribute :ledger_max_write_bytes,              Uint32
    attribute :tx_max_read_ledger_entries,          Uint32
    attribute :tx_max_read_bytes,                   Uint32
    attribute :tx_max_write_ledger_entries,         Uint32
    attribute :tx_max_write_bytes,                  Uint32
    attribute :fee_read_ledger_entry,               Int64
    attribute :fee_write_ledger_entry,              Int64
    attribute :fee_read1_kb,                        Int64
    attribute :bucket_list_target_size_bytes,       Int64
    attribute :write_fee1_kb_bucket_list_low,       Int64
    attribute :write_fee1_kb_bucket_list_high,      Int64
    attribute :bucket_list_write_fee_growth_factor, Uint32
  end
end
