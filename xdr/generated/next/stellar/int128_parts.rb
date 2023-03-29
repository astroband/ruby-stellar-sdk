# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Int128Parts {
#       // Both signed and unsigned 128-bit ints
#       // are transported in a pair of uint64s
#       // to reduce the risk of sign-extension.
#       uint64 lo;
#       uint64 hi;
#   };
#
# ===========================================================================
module Stellar
  class Int128Parts < XDR::Struct
    attribute :lo, Uint64
    attribute :hi, Uint64
  end
end
