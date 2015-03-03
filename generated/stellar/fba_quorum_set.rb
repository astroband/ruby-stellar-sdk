# Automatically generated from xdr/FBAXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class FBAQuorumSet < XDR::Struct
    attribute :threshold,  Uint32
    attribute :validators, XDR::VarArray[Hash]
  end
end
