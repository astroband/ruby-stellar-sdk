# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct DecoratedSignature
#   {
#       SignatureHint hint;  // first 4 bytes of the public key, used as a hint
#       Signature signature; // actual signature
#   };
#
# ===========================================================================
module Stellar
  class DecoratedSignature < XDR::Struct
    attribute :hint,      SignatureHint
    attribute :signature, Signature
  end
end
