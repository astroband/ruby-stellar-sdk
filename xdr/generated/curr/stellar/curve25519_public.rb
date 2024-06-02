# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Curve25519Public
#   {
#       opaque key[32];
#   };
#
# ===========================================================================
module Stellar
  class Curve25519Public < XDR::Struct
    attribute :key, XDR::Opaque[32]
  end
end
