# Automatically generated on 2015-03-31T14:32:44-07:00
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
