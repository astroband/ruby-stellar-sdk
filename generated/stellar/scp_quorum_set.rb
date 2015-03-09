# Automatically generated from xdr/SCPXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class SCPQuorumSet < XDR::Struct
    attribute :threshold,  Uint32
    attribute :validators, XDR::VarArray[Hash]
  end
end
