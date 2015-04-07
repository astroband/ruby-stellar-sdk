# Automatically generated on 2015-04-07T10:52:07-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct StellarBallot
#   {
#       uint256 nodeID;
#       Signature signature;
#       StellarBallotValue value;
#   };
#
# ===========================================================================
module Stellar
  class StellarBallot < XDR::Struct
    attribute :node_id,   Uint256
    attribute :signature, Signature
    attribute :value,     StellarBallotValue
  end
end
