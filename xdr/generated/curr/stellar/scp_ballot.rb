# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCPBallot
#   {
#       uint32 counter; // n
#       Value value;    // x
#   };
#
# ===========================================================================
module Stellar
  class SCPBallot < XDR::Struct
    attribute :counter, Uint32
    attribute :value,   Value
  end
end
