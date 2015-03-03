# Automatically generated from xdr/FBAXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class FBABallot < XDR::Struct
    attribute :counter, Uint32
    attribute :value,   Value
  end
end
