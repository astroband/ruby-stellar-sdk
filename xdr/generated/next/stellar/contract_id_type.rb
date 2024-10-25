# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ContractIDType
#   {
#       CONTRACT_ID_FROM_SOURCE_ACCOUNT = 0,
#       CONTRACT_ID_FROM_ED25519_PUBLIC_KEY = 1,
#       CONTRACT_ID_FROM_ASSET = 2
#   };
#
# ===========================================================================
module Stellar
  class ContractIDType < XDR::Enum
    member :contract_id_from_source_account,     0
    member :contract_id_from_ed25519_public_key, 1
    member :contract_id_from_asset,              2

    seal
  end
end
