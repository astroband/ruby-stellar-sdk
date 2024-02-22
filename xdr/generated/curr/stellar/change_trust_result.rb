# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ChangeTrustResult switch (ChangeTrustResultCode code)
#   {
#   case CHANGE_TRUST_SUCCESS:
#       void;
#   case CHANGE_TRUST_MALFORMED:
#   case CHANGE_TRUST_NO_ISSUER:
#   case CHANGE_TRUST_INVALID_LIMIT:
#   case CHANGE_TRUST_LOW_RESERVE:
#   case CHANGE_TRUST_SELF_NOT_ALLOWED:
#   case CHANGE_TRUST_TRUST_LINE_MISSING:
#   case CHANGE_TRUST_CANNOT_DELETE:
#   case CHANGE_TRUST_NOT_AUTH_MAINTAIN_LIABILITIES:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ChangeTrustResult < XDR::Union
    switch_on ChangeTrustResultCode, :code

    switch :change_trust_success
    switch :change_trust_malformed
    switch :change_trust_no_issuer
    switch :change_trust_invalid_limit
    switch :change_trust_low_reserve
    switch :change_trust_self_not_allowed
    switch :change_trust_trust_line_missing
    switch :change_trust_cannot_delete
    switch :change_trust_not_auth_maintain_liabilities

  end
end
