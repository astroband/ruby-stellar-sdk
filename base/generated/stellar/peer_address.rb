# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct PeerAddress
#   {
#       union switch (IPAddrType type)
#       {
#       case IPv4:
#           opaque ipv4[4];
#       case IPv6:
#           opaque ipv6[16];
#       }
#       ip;
#       uint32 port;
#       uint32 numFailures;
#   };
#
# ===========================================================================
module Stellar
  class PeerAddress < XDR::Struct
    include XDR::Namespace

    autoload :Ip

    attribute :ip,           Ip
    attribute :port,         Uint32
    attribute :num_failures, Uint32
  end
end
