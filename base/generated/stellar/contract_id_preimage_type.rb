# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ContractIDPreimageType
#   {
#       CONTRACT_ID_PREIMAGE_FROM_ADDRESS = 0,
#       CONTRACT_ID_PREIMAGE_FROM_ASSET = 1
#   };
#
# ===========================================================================
module Stellar
  class ContractIDPreimageType < XDR::Enum
    member :contract_id_preimage_from_address, 0
    member :contract_id_preimage_from_asset,   1

    seal
  end
end
