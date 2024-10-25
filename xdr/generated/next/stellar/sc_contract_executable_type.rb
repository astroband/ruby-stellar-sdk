# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCContractExecutableType
#   {
#       SCCONTRACT_EXECUTABLE_WASM_REF = 0,
#       SCCONTRACT_EXECUTABLE_TOKEN = 1
#   };
#
# ===========================================================================
module Stellar
  class SCContractExecutableType < XDR::Enum
    member :sccontract_executable_wasm_ref, 0
    member :sccontract_executable_token,    1

    seal
  end
end
