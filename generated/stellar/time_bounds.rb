# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TimeBounds
#   {
#       TimePoint minTime;
#       TimePoint maxTime; // 0 here means no maxTime
#   };
#
# ===========================================================================
module Stellar
  class TimeBounds < XDR::Struct
    attribute :min_time, TimePoint
    attribute :max_time, TimePoint
  end
end
