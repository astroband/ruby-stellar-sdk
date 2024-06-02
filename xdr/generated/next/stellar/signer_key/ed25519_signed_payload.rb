# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           /* Public key that must sign the payload. */
#           uint256 ed25519;
#           /* Payload to be raw signed by ed25519. */
#           opaque payload<64>;
#       }
#
# ===========================================================================
module Stellar
  class SignerKey
    class Ed25519SignedPayload < XDR::Struct
      attribute :ed25519, Uint256
      attribute :payload, XDR::VarOpaque[64]
    end
  end
end
