# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum CryptoKeyType
#   {
#       KEY_TYPE_ED25519 = 0,
#       KEY_TYPE_PRE_AUTH_TX = 1,
#       KEY_TYPE_HASH_X = 2
#   };
#
# ===========================================================================
module Stellar
  class CryptoKeyType < XDR::Enum
    member :key_type_ed25519,     0
    member :key_type_pre_auth_tx, 1
    member :key_type_hash_x,      2

    seal
  end
end
