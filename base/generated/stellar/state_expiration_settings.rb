# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct StateExpirationSettings {
#       uint32 maxEntryExpiration;
#       uint32 minTempEntryExpiration;
#       uint32 minPersistentEntryExpiration;
#
#       // rent_fee = wfee_rate_average / rent_rate_denominator_for_type
#       int64 persistentRentRateDenominator;
#       int64 tempRentRateDenominator;
#
#       // max number of entries that emit expiration meta in a single ledger
#       uint32 maxEntriesToExpire;
#
#       // Number of snapshots to use when calculating average BucketList size
#       uint32 bucketListSizeWindowSampleSize;
#
#       // Maximum number of bytes that we scan for eviction per ledger
#       uint64 evictionScanSize;
#
#       // Lowest BucketList level to be scanned to evict entries
#       uint32 startingEvictionScanLevel;
#   };
#
# ===========================================================================
module Stellar
  class StateExpirationSettings < XDR::Struct
    attribute :max_entry_expiration,                Uint32
    attribute :min_temp_entry_expiration,           Uint32
    attribute :min_persistent_entry_expiration,     Uint32
    attribute :persistent_rent_rate_denominator,    Int64
    attribute :temp_rent_rate_denominator,          Int64
    attribute :max_entries_to_expire,               Uint32
    attribute :bucket_list_size_window_sample_size, Uint32
    attribute :eviction_scan_size,                  Uint64
    attribute :starting_eviction_scan_level,        Uint32
  end
end
