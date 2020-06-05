# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct HmacSha256Key
#   {
#           opaque key[32];
#   };
#
# ===========================================================================
module Stellar
  class HmacSha256Key < XDR::Struct
    attribute :key, XDR::Opaque[32]
  end
end
