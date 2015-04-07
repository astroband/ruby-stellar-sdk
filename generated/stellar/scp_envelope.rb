# Automatically generated on 2015-04-07T10:52:07-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct SCPEnvelope
#   {
#       uint256 nodeID; // v
#       SCPStatement statement;
#       Signature signature;
#   };
#
# ===========================================================================
module Stellar
  class SCPEnvelope < XDR::Struct
    attribute :node_id,   Uint256
    attribute :statement, SCPStatement
    attribute :signature, Signature
  end
end