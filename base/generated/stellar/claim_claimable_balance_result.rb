# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ClaimClaimableBalanceResult switch (ClaimClaimableBalanceResultCode code)
#   {
#   case CLAIM_CLAIMABLE_BALANCE_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ClaimClaimableBalanceResult < XDR::Union
    switch_on ClaimClaimableBalanceResultCode, :code

    switch :claim_claimable_balance_success
    switch :default

  end
end
