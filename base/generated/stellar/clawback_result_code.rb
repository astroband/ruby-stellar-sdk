# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ClawbackResultCode
#   {
#       // codes considered as "success" for the operation
#       CLAWBACK_SUCCESS = 0,
#
#       // codes considered as "failure" for the operation
#       CLAWBACK_MALFORMED = -1,
#       CLAWBACK_NOT_CLAWBACK_ENABLED = -2,
#       CLAWBACK_NO_TRUST = -3,
#       CLAWBACK_UNDERFUNDED = -4
#   };
#
# ===========================================================================
module Stellar
  class ClawbackResultCode < XDR::Enum
    member :clawback_success,              0
    member :clawback_malformed,            -1
    member :clawback_not_clawback_enabled, -2
    member :clawback_no_trust,             -3
    member :clawback_underfunded,          -4

    seal
  end
end
