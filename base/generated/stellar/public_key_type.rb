# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum PublicKeyType
#   {
#       PUBLIC_KEY_TYPE_ED25519 = KEY_TYPE_ED25519
#   };
#
# ===========================================================================
module Stellar
  class PublicKeyType < XDR::Enum
    member :public_key_type_ed25519, 0

    seal
  end
end
