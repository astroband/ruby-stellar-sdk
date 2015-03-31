# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct SCPQuorumSet
#   {
#       uint32 threshold;
#       Hash validators<>;
#   };
#
# ===========================================================================
module Stellar
  class SCPQuorumSet < XDR::Struct
    attribute :threshold,  Uint32
    attribute :validators, XDR::VarArray[Hash]
  end
end
