# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum InvokeHostFunctionResultCode
#   {
#       // codes considered as "success" for the operation
#       INVOKE_HOST_FUNCTION_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       INVOKE_HOST_FUNCTION_MALFORMED = -1,
#       INVOKE_HOST_FUNCTION_TRAPPED = -2
#   };
#
# ===========================================================================
module Stellar
  class InvokeHostFunctionResultCode < XDR::Enum
    member :invoke_host_function_success,   0
    member :invoke_host_function_malformed, -1
    member :invoke_host_function_trapped,   -2

    seal
  end
end
