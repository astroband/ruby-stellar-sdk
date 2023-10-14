# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ContractExecutable switch (ContractExecutableType type)
#   {
#   case CONTRACT_EXECUTABLE_WASM:
#       Hash wasm_hash;
#   case CONTRACT_EXECUTABLE_TOKEN:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ContractExecutable < XDR::Union
    switch_on ContractExecutableType, :type

    switch :contract_executable_wasm, :wasm_hash
    switch :contract_executable_token

    attribute :wasm_hash, Hash
  end
end
