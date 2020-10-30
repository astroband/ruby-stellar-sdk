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
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class CreateClaimableBalanceResult < XDR::Union
    switch_on CreateClaimableBalanceResultCode, :code

    switch :create_claimable_balance_success, :balance_id
    switch :default

    attribute :balance_id, ClaimableBalanceID
  end
end
