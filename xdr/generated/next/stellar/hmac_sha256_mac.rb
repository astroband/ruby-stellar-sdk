# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct HmacSha256Mac
#   {
#       opaque mac[32];
#   };
#
# ===========================================================================
module Stellar
  class HmacSha256Mac < XDR::Struct
    attribute :mac, XDR::Opaque[32]
  end
end
