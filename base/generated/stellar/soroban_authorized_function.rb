# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SorobanAuthorizedFunction switch (SorobanAuthorizedFunctionType type)
#   {
#   case SOROBAN_AUTHORIZED_FUNCTION_TYPE_CONTRACT_FN:
#       InvokeContractArgs contractFn;
#   case SOROBAN_AUTHORIZED_FUNCTION_TYPE_CREATE_CONTRACT_HOST_FN:
#       CreateContractArgs createContractHostFn;
#   };
#
# ===========================================================================
module Stellar
  class SorobanAuthorizedFunction < XDR::Union
    switch_on SorobanAuthorizedFunctionType, :type

    switch :soroban_authorized_function_type_contract_fn,             :contract_fn
    switch :soroban_authorized_function_type_create_contract_host_fn, :create_contract_host_fn

    attribute :contract_fn,             InvokeContractArgs
    attribute :create_contract_host_fn, CreateContractArgs
  end
end
