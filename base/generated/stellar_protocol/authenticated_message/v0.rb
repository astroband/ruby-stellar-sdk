# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           uint64 sequence;
#           StellarMessage message;
#           HmacSha256Mac mac;
#       }
#
# ===========================================================================
module StellarProtocol
  class AuthenticatedMessage
    class V0 < XDR::Struct
      attribute :sequence, Uint64
      attribute :message,  StellarMessage
      attribute :mac,      HmacSha256Mac
    end
  end
end
