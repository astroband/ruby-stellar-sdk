# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union HostFunction switch (HostFunctionType type)
#   {
#   case HOST_FUNCTION_TYPE_INVOKE_CONTRACT:
#       InvokeContractArgs invokeContract;
#   case HOST_FUNCTION_TYPE_CREATE_CONTRACT:
#       CreateContractArgs createContract;
#   case HOST_FUNCTION_TYPE_UPLOAD_CONTRACT_WASM:
#       opaque wasm<>;
#   };
#
# ===========================================================================
module Stellar
  class HostFunction < XDR::Union
    switch_on HostFunctionType, :type

    switch :host_function_type_invoke_contract,      :invoke_contract
    switch :host_function_type_create_contract,      :create_contract
    switch :host_function_type_upload_contract_wasm, :wasm

    attribute :invoke_contract, InvokeContractArgs
    attribute :create_contract, CreateContractArgs
    attribute :wasm,            XDR::VarOpaque[]
  end
end
