# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Int128Parts {
#       int64 hi;
#       uint64 lo;
#   };
#
# ===========================================================================
module Stellar
  class Int128Parts < XDR::Struct
    attribute :hi, Int64
    attribute :lo, Uint64
  end
end
