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
#       CHANGE_TRUST_LOW_RESERVE = -4 // not enough funds to create a new trust line
#   };
#
# ===========================================================================
module Stellar
  class ChangeTrustResultCode < XDR::Enum
    member :change_trust_success,       0
    member :change_trust_malformed,     -1
    member :change_trust_no_issuer,     -2
    member :change_trust_invalid_limit, -3
    member :change_trust_low_reserve,   -4

    seal
  end
end
