# Automatically generated from xdr/Stellar-overlay.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class StellarBallot < XDR::Struct

                          
    attribute :node_id,   Uint256
    attribute :signature, Signature
    attribute :value,     StellarBallotValue
  end
end
