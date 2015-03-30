# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class PeerAddress < XDR::Struct
    attribute :ip,           XDR::Opaque[4]
    attribute :port,         Uint32
    attribute :num_failures, Uint32
  end
end
