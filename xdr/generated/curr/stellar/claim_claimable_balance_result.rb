# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ClaimClaimableBalanceResult switch (ClaimClaimableBalanceResultCode code)
#   {
#   case CLAIM_CLAIMABLE_BALANCE_SUCCESS:
#       void;
#   case CLAIM_CLAIMABLE_BALANCE_DOES_NOT_EXIST:
#   case CLAIM_CLAIMABLE_BALANCE_CANNOT_CLAIM:
#   case CLAIM_CLAIMABLE_BALANCE_LINE_FULL:
#   case CLAIM_CLAIMABLE_BALANCE_NO_TRUST:
#   case CLAIM_CLAIMABLE_BALANCE_NOT_AUTHORIZED:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ClaimClaimableBalanceResult < XDR::Union
    switch_on ClaimClaimableBalanceResultCode, :code

    switch :claim_claimable_balance_success
    switch :claim_claimable_balance_does_not_exist
    switch :claim_claimable_balance_cannot_claim
    switch :claim_claimable_balance_line_full
    switch :claim_claimable_balance_no_trust
    switch :claim_claimable_balance_not_authorized

  end
end
