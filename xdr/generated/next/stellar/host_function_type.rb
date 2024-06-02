# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum HostFunctionType
#   {
#       HOST_FUNCTION_TYPE_INVOKE_CONTRACT = 0,
#       HOST_FUNCTION_TYPE_CREATE_CONTRACT = 1,
#       HOST_FUNCTION_TYPE_INSTALL_CONTRACT_CODE = 2
#   };
#
# ===========================================================================
module Stellar
  class HostFunctionType < XDR::Enum
    member :host_function_type_invoke_contract,       0
    member :host_function_type_create_contract,       1
    member :host_function_type_install_contract_code, 2

    seal
  end
end
