# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TimeBounds
#   {
#       uint64 minTime;
#       uint64 maxTime; // 0 here means no maxTime
#   };
#
# ===========================================================================
module Stellar
  class TimeBounds < XDR::Struct
    attribute :min_time, Uint64
    attribute :max_time, Uint64
  end
end
