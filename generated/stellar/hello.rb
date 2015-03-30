# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class Hello < XDR::Struct
    attribute :protocol_version, XDR::Int
    attribute :version_str,      XDR::String[100]
    attribute :listening_port,   XDR::Int
    attribute :peer_id,          XDR::Opaque[32]
  end
end
