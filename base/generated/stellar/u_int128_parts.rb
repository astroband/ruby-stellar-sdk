# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct UInt128Parts {
#       uint64 hi;
#       uint64 lo;
#   };
#
# ===========================================================================
module Stellar
  class UInt128Parts < XDR::Struct
    attribute :hi, Uint64
    attribute :lo, Uint64
  end
end
