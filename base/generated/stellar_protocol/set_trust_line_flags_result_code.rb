# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SetTrustLineFlagsResultCode
#   {
#       // codes considered as "success" for the operation
#       SET_TRUST_LINE_FLAGS_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       SET_TRUST_LINE_FLAGS_MALFORMED = -1,
#       SET_TRUST_LINE_FLAGS_NO_TRUST_LINE = -2,
#       SET_TRUST_LINE_FLAGS_CANT_REVOKE = -3,
#       SET_TRUST_LINE_FLAGS_INVALID_STATE = -4
#   };
#
# ===========================================================================
module StellarProtocol
  class SetTrustLineFlagsResultCode < XDR::Enum
    member :set_trust_line_flags_success,       0
    member :set_trust_line_flags_malformed,     -1
    member :set_trust_line_flags_no_trust_line, -2
    member :set_trust_line_flags_cant_revoke,   -3
    member :set_trust_line_flags_invalid_state, -4

    seal
  end
end
