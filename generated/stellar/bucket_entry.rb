# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union BucketEntry switch (BucketEntryType type)
#   {
#   case LIVEENTRY:
#       LedgerEntry liveEntry;
#   
#   case DEADENTRY:
#       LedgerKey deadEntry;
#   };
#
# ===========================================================================
module Stellar
  class BucketEntry < XDR::Union
    switch_on BucketEntryType, :type

    switch :liveentry, :live_entry
    switch :deadentry, :dead_entry

    attribute :live_entry, LedgerEntry
    attribute :dead_entry, LedgerKey
  end
end
