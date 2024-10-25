# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCHostContextErrorCode
#   {
#       HOST_CONTEXT_UNKNOWN_ERROR = 0,
#       HOST_CONTEXT_NO_CONTRACT_RUNNING = 1
#   };
#
# ===========================================================================
module Stellar
  class SCHostContextErrorCode < XDR::Enum
    member :host_context_unknown_error,       0
    member :host_context_no_contract_running, 1

    seal
  end
end
