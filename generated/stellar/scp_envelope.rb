# Automatically generated from xdr/SCPXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class SCPEnvelope < XDR::Struct
    attribute :node_id,   Uint256
    attribute :statement, SCPStatement
    attribute :signature, Signature
  end
end
