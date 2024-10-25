# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union HostFunction switch (HostFunctionType type)
#   {
#   case HOST_FUNCTION_TYPE_INVOKE_CONTRACT:
#       SCVec invokeArgs;
#   case HOST_FUNCTION_TYPE_CREATE_CONTRACT:
#       CreateContractArgs createContractArgs;
#   case HOST_FUNCTION_TYPE_INSTALL_CONTRACT_CODE:
#       InstallContractCodeArgs installContractCodeArgs;
#   };
#
# ===========================================================================
module Stellar
  class HostFunction < XDR::Union
    switch_on HostFunctionType, :type

    switch :host_function_type_invoke_contract,       :invoke_args
    switch :host_function_type_create_contract,       :create_contract_args
    switch :host_function_type_install_contract_code, :install_contract_code_args

    attribute :invoke_args,                SCVec
    attribute :create_contract_args,       CreateContractArgs
    attribute :install_contract_code_args, InstallContractCodeArgs
  end
end
