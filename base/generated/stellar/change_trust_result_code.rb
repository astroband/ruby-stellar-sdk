# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ChangeTrustResultCode
#   {
#       // codes considered as "success" for the operation
#       CHANGE_TRUST_SUCCESS = 0,
#       // codes considered as "failure" for the operation
#       CHANGE_TRUST_MALFORMED = -1,     // bad input
#       CHANGE_TRUST_NO_ISSUER = -2,     // could not find issuer
#       CHANGE_TRUST_INVALID_LIMIT = -3, // cannot drop limit below balance
#                                        // cannot create with a limit of 0
#       CHANGE_TRUST_LOW_RESERVE =
#           -4, // not enough funds to create a new trust line,
#       CHANGE_TRUST_SELF_NOT_ALLOWED = -5, // trusting self is not allowed
#       CHANGE_TRUST_TRUST_LINE_MISSING = -6, // Asset trustline is missing for pool
#       CHANGE_TRUST_CANNOT_DELETE = -7, // Asset trustline is still referenced in a pool
#       CHANGE_TRUST_NOT_AUTH_MAINTAIN_LIABILITIES = -8 // Asset trustline is deauthorized
#   };
#
# ===========================================================================
module Stellar
  class ChangeTrustResultCode < XDR::Enum
    member :change_trust_success,                       0
    member :change_trust_malformed,                     -1
    member :change_trust_no_issuer,                     -2
    member :change_trust_invalid_limit,                 -3
    member :change_trust_low_reserve,                   -4
    member :change_trust_self_not_allowed,              -5
    member :change_trust_trust_line_missing,            -6
    member :change_trust_cannot_delete,                 -7
    member :change_trust_not_auth_maintain_liabilities, -8

    seal
  end
end
