# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ContractExecutableType
#   {
#       CONTRACT_EXECUTABLE_WASM = 0,
#       CONTRACT_EXECUTABLE_STELLAR_ASSET = 1
#   };
#
# ===========================================================================
module Stellar
  class ContractExecutableType < XDR::Enum
    member :contract_executable_wasm,          0
    member :contract_executable_stellar_asset, 1

    seal
  end
end
