# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (IPAddrType type)
#       {
#       case IPv4:
#           opaque ipv4[4];
#       case IPv6:
#           opaque ipv6[16];
#       }
#
# ===========================================================================
module StellarProtocol
  class PeerAddress
    class Ip < XDR::Union
      switch_on IPAddrType, :type

      switch :i_pv4, :ipv4
      switch :i_pv6, :ipv6

      attribute :ipv4, XDR::Opaque[4]
      attribute :ipv6, XDR::Opaque[16]
    end
  end
end
