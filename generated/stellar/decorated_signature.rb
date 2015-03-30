# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class DecoratedSignature < XDR::Struct
    attribute :hint,      XDR::Opaque[4]
    attribute :signature, Uint512
  end
end
