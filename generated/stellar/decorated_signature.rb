# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class DecoratedSignature < XDR::Struct
    attribute :hint,      XDR::Opaque[4]
    attribute :signature, Uint512
  end
end
