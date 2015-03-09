# Automatically generated from xdr/SCPXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class SCPBallot < XDR::Struct
    attribute :counter, Uint32
    attribute :value,   Value
  end
end
