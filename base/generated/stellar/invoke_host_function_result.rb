# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union InvokeHostFunctionResult switch (InvokeHostFunctionResultCode code)
#   {
#   case INVOKE_HOST_FUNCTION_SUCCESS:
#       Hash success; // sha256(InvokeHostFunctionSuccessPreImage)
#   case INVOKE_HOST_FUNCTION_MALFORMED:
#   case INVOKE_HOST_FUNCTION_TRAPPED:
#   case INVOKE_HOST_FUNCTION_RESOURCE_LIMIT_EXCEEDED:
#   case INVOKE_HOST_FUNCTION_ENTRY_EXPIRED:
#   case INVOKE_HOST_FUNCTION_INSUFFICIENT_REFUNDABLE_FEE:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class InvokeHostFunctionResult < XDR::Union
    switch_on InvokeHostFunctionResultCode, :code

    switch :invoke_host_function_success,                   :success
    switch :invoke_host_function_malformed
    switch :invoke_host_function_trapped
    switch :invoke_host_function_resource_limit_exceeded
    switch :invoke_host_function_entry_expired
    switch :invoke_host_function_insufficient_refundable_fee

    attribute :success, Hash
  end
end
