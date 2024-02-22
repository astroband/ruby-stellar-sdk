# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCHostFnErrorCode
#   {
#       HOST_FN_UNKNOWN_ERROR = 0,
#       HOST_FN_UNEXPECTED_HOST_FUNCTION_ACTION = 1,
#       HOST_FN_INPUT_ARGS_WRONG_LENGTH = 2,
#       HOST_FN_INPUT_ARGS_WRONG_TYPE = 3,
#       HOST_FN_INPUT_ARGS_INVALID = 4
#   };
#
# ===========================================================================
module Stellar
  class SCHostFnErrorCode < XDR::Enum
    member :host_fn_unknown_error,                   0
    member :host_fn_unexpected_host_function_action, 1
    member :host_fn_input_args_wrong_length,         2
    member :host_fn_input_args_wrong_type,           3
    member :host_fn_input_args_invalid,              4

    seal
  end
end
