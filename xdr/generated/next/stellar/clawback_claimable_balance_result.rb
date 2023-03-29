# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ClawbackClaimableBalanceResult switch (
#       ClawbackClaimableBalanceResultCode code)
#   {
#   case CLAWBACK_CLAIMABLE_BALANCE_SUCCESS:
#       void;
#   case CLAWBACK_CLAIMABLE_BALANCE_DOES_NOT_EXIST:
#   case CLAWBACK_CLAIMABLE_BALANCE_NOT_ISSUER:
#   case CLAWBACK_CLAIMABLE_BALANCE_NOT_CLAWBACK_ENABLED:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ClawbackClaimableBalanceResult < XDR::Union
    switch_on ClawbackClaimableBalanceResultCode, :code

    switch :clawback_claimable_balance_success
    switch :clawback_claimable_balance_does_not_exist
    switch :clawback_claimable_balance_not_issuer
    switch :clawback_claimable_balance_not_clawback_enabled

  end
end
