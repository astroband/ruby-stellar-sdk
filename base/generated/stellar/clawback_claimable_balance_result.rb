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
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ClawbackClaimableBalanceResult < XDR::Union
    switch_on ClawbackClaimableBalanceResultCode, :code

    switch :clawback_claimable_balance_success
    switch :default

  end
end
