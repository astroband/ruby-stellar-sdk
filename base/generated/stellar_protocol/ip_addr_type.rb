# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum IPAddrType
#   {
#       IPv4 = 0,
#       IPv6 = 1
#   };
#
# ===========================================================================
module StellarProtocol
  class IPAddrType < XDR::Enum
    member :i_pv4, 0
    member :i_pv6, 1

    seal
  end
end
