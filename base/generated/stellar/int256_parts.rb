# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Int256Parts {
#       int64 hi_hi;
#       uint64 hi_lo;
#       uint64 lo_hi;
#       uint64 lo_lo;
#   };
#
# ===========================================================================
module Stellar
  class Int256Parts < XDR::Struct
    attribute :hi_hi, Int64
    attribute :hi_lo, Uint64
    attribute :lo_hi, Uint64
    attribute :lo_lo, Uint64
  end
end
