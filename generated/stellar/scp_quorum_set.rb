# Automatically generated on 2015-06-08T11:39:14-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct SCPQuorumSet
#   {
#       uint32 threshold;
#   	Hash validators<>;
#       SCPQuorumSet innerSets<>;
#   };
#
# ===========================================================================
module Stellar
  class SCPQuorumSet < XDR::Struct
    attribute :threshold,  Uint32
    attribute :validators, XDR::VarArray[Hash]
    attribute :inner_sets, XDR::VarArray[SCPQuorumSet]
  end
end
