# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SignerKeyType
#   {
#       SIGNER_KEY_TYPE_ED25519 = KEY_TYPE_ED25519,
#       SIGNER_KEY_TYPE_HASH_TX = KEY_TYPE_HASH_TX,
#       SIGNER_KEY_TYPE_HASH_X = KEY_TYPE_HASH_X
#   };
#
# ===========================================================================
module Stellar
  class SignerKeyType < XDR::Enum
    member :signer_key_type_ed25519, 0
    member :signer_key_type_hash_tx, 1
    member :signer_key_type_hash_x,  2

    seal
  end
end
