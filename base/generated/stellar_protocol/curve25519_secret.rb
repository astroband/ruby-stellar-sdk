# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Curve25519Secret
#   {
#       opaque key[32];
#   };
#
# ===========================================================================
module StellarProtocol
  class Curve25519Secret < XDR::Struct
    attribute :key, XDR::Opaque[32]
  end
end
