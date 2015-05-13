# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct TimeBounds
#   {
#       uint64 minTime;
#       uint64 maxTime;
#   };
#
# ===========================================================================
module Stellar
  class TimeBounds < XDR::Struct
    attribute :min_time, Uint64
    attribute :max_time, Uint64
  end
end
