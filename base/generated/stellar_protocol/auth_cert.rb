# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct AuthCert
#   {
#       Curve25519Public pubkey;
#       uint64 expiration;
#       Signature sig;
#   };
#
# ===========================================================================
module StellarProtocol
  class AuthCert < XDR::Struct
    attribute :pubkey,     Curve25519Public
    attribute :expiration, Uint64
    attribute :sig,        Signature
  end
end
