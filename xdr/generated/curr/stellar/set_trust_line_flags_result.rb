# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SetTrustLineFlagsResult switch (SetTrustLineFlagsResultCode code)
#   {
#   case SET_TRUST_LINE_FLAGS_SUCCESS:
#       void;
#   case SET_TRUST_LINE_FLAGS_MALFORMED:
#   case SET_TRUST_LINE_FLAGS_NO_TRUST_LINE:
#   case SET_TRUST_LINE_FLAGS_CANT_REVOKE:
#   case SET_TRUST_LINE_FLAGS_INVALID_STATE:
#   case SET_TRUST_LINE_FLAGS_LOW_RESERVE:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class SetTrustLineFlagsResult < XDR::Union
    switch_on SetTrustLineFlagsResultCode, :code

    switch :set_trust_line_flags_success
    switch :set_trust_line_flags_malformed
    switch :set_trust_line_flags_no_trust_line
    switch :set_trust_line_flags_cant_revoke
    switch :set_trust_line_flags_invalid_state
    switch :set_trust_line_flags_low_reserve

  end
end
