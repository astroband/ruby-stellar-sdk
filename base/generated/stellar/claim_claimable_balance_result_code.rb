# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ClaimClaimableBalanceResultCode
#   {
#       CLAIM_CLAIMABLE_BALANCE_SUCCESS = 0,
#       CLAIM_CLAIMABLE_BALANCE_DOES_NOT_EXIST = -1,
#       CLAIM_CLAIMABLE_BALANCE_CANNOT_CLAIM = -2,
#       CLAIM_CLAIMABLE_BALANCE_LINE_FULL = -3,
#       CLAIM_CLAIMABLE_BALANCE_NO_TRUST = -4,
#       CLAIM_CLAIMABLE_BALANCE_NOT_AUTHORIZED = -5
#   
#   };
#
# ===========================================================================
module Stellar
  class ClaimClaimableBalanceResultCode < XDR::Enum
    member :claim_claimable_balance_success,        0
    member :claim_claimable_balance_does_not_exist, -1
    member :claim_claimable_balance_cannot_claim,   -2
    member :claim_claimable_balance_line_full,      -3
    member :claim_claimable_balance_no_trust,       -4
    member :claim_claimable_balance_not_authorized, -5

    seal
  end
end
