# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ThresholdIndexes
#   {
#       THRESHOLD_MASTER_WEIGHT = 0,
#       THRESHOLD_LOW = 1,
#       THRESHOLD_MED = 2,
#       THRESHOLD_HIGH = 3
#   };
#
# ===========================================================================
module Stellar
  class ThresholdIndexes < XDR::Enum
    member :threshold_master_weight, 0
    member :threshold_low,           1
    member :threshold_med,           2
    member :threshold_high,          3

    seal
  end
end
