# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ContractIDPublicKeyType
#   {
#       CONTRACT_ID_PUBLIC_KEY_SOURCE_ACCOUNT = 0,
#       CONTRACT_ID_PUBLIC_KEY_ED25519 = 1
#   };
#
# ===========================================================================
module Stellar
  class ContractIDPublicKeyType < XDR::Enum
    member :contract_id_public_key_source_account, 0
    member :contract_id_public_key_ed25519,        1

    seal
  end
end
