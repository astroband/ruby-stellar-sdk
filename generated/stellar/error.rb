# Automatically generated from xdr/Stellar-overlay.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class Error < XDR::Struct

                     
    attribute :code, XDR::Int
    attribute :msg,  XDR::String[100]
  end
end
