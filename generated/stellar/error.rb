# Automatically generated from xdr/Stellar-overlay.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class Error < XDR::Struct

                     
    attribute :code, XDR::Int
    attribute :msg,  XDR::String[100]
  end
end
