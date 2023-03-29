# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union InvokeHostFunctionResult switch (InvokeHostFunctionResultCode code)
#   {
#   case INVOKE_HOST_FUNCTION_SUCCESS:
#       SCVal success;
#   case INVOKE_HOST_FUNCTION_MALFORMED:
#   case INVOKE_HOST_FUNCTION_TRAPPED:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class InvokeHostFunctionResult < XDR::Union
    switch_on InvokeHostFunctionResultCode, :code

    switch :invoke_host_function_success, :success
    switch :invoke_host_function_malformed
    switch :invoke_host_function_trapped

    attribute :success, SCVal
  end
end
