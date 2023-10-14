# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct EvictionIterator {
#       uint32 bucketListLevel;
#       bool isCurrBucket;
#       uint64 bucketFileOffset;
#   };
#
# ===========================================================================
module Stellar
  class EvictionIterator < XDR::Struct
    attribute :bucket_list_level,  Uint32
    attribute :is_curr_bucket,     XDR::Bool
    attribute :bucket_file_offset, Uint64
  end
end
