# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SorobanAuthorizedFunctionType
#   {
#       SOROBAN_AUTHORIZED_FUNCTION_TYPE_CONTRACT_FN = 0,
#       SOROBAN_AUTHORIZED_FUNCTION_TYPE_CREATE_CONTRACT_HOST_FN = 1
#   };
#
# ===========================================================================
module Stellar
  class SorobanAuthorizedFunctionType < XDR::Enum
    member :soroban_authorized_function_type_contract_fn,             0
    member :soroban_authorized_function_type_create_contract_host_fn, 1

    seal
  end
end
