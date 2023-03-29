# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCContractExecutable switch (SCContractExecutableType type)
#   {
#   case SCCONTRACT_EXECUTABLE_WASM_REF:
#       Hash wasm_id;
#   case SCCONTRACT_EXECUTABLE_TOKEN:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class SCContractExecutable < XDR::Union
    switch_on SCContractExecutableType, :type

    switch :sccontract_executable_wasm_ref, :wasm_id
    switch :sccontract_executable_token

    attribute :wasm_id, Hash
  end
end
