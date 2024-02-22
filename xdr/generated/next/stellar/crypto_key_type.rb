# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum CryptoKeyType
#   {
#       KEY_TYPE_ED25519 = 0,
#       KEY_TYPE_PRE_AUTH_TX = 1,
#       KEY_TYPE_HASH_X = 2,
#       KEY_TYPE_ED25519_SIGNED_PAYLOAD = 3,
#       // MUXED enum values for supported type are derived from the enum values
#       // above by ORing them with 0x100
#       KEY_TYPE_MUXED_ED25519 = 0x100
#   };
#
# ===========================================================================
module Stellar
  class CryptoKeyType < XDR::Enum
    member :key_type_ed25519,                0
    member :key_type_pre_auth_tx,            1
    member :key_type_hash_x,                 2
    member :key_type_ed25519_signed_payload, 3
    member :key_type_muxed_ed25519,          256

    seal
  end
end
