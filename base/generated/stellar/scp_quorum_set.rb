# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCPQuorumSet
#   {
#       uint32 threshold;
#       NodeID validators<>;
#       SCPQuorumSet innerSets<>;
#   };
#
# ===========================================================================
module Stellar
  class SCPQuorumSet < XDR::Struct
    attribute :threshold,  Uint32
    attribute :validators, XDR::VarArray[NodeID]
    attribute :inner_sets, XDR::VarArray[SCPQuorumSet]
  end
end
