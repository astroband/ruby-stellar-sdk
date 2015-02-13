# Automatically generated from xdr/Stellar-overlay.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class Hello < XDR::Struct

                                 
    attribute :protocol_version, XDR::Int
    attribute :version_str,      XDR::String[100]
    attribute :listening_port,   XDR::Int
    attribute :peer_id,          XDR::Opaque[32]
  end
end
