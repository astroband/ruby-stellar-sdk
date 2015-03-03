# Automatically generated from xdr/FBAXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class FBAEnvelope < XDR::Struct
    attribute :node_id,   Uint256
    attribute :statement, FBAStatement
    attribute :signature, Signature
  end
end
