# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union CreateClaimableBalanceResult switch (
#       CreateClaimableBalanceResultCode code)
#   {
#   case CREATE_CLAIMABLE_BALANCE_SUCCESS:
#       ClaimableBalanceID balanceID;
#   case CREATE_CLAIMABLE_BALANCE_MALFORMED:
#   case CREATE_CLAIMABLE_BALANCE_LOW_RESERVE:
#   case CREATE_CLAIMABLE_BALANCE_NO_TRUST:
#   case CREATE_CLAIMABLE_BALANCE_NOT_AUTHORIZED:
#   case CREATE_CLAIMABLE_BALANCE_UNDERFUNDED:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class CreateClaimableBalanceResult < XDR::Union
    switch_on CreateClaimableBalanceResultCode, :code

    switch :create_claimable_balance_success,      :balance_id
    switch :create_claimable_balance_malformed
    switch :create_claimable_balance_low_reserve
    switch :create_claimable_balance_no_trust
    switch :create_claimable_balance_not_authorized
    switch :create_claimable_balance_underfunded

    attribute :balance_id, ClaimableBalanceID
  end
end
