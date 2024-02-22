# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum CreateClaimableBalanceResultCode
#   {
#       CREATE_CLAIMABLE_BALANCE_SUCCESS = 0,
#       CREATE_CLAIMABLE_BALANCE_MALFORMED = -1,
#       CREATE_CLAIMABLE_BALANCE_LOW_RESERVE = -2,
#       CREATE_CLAIMABLE_BALANCE_NO_TRUST = -3,
#       CREATE_CLAIMABLE_BALANCE_NOT_AUTHORIZED = -4,
#       CREATE_CLAIMABLE_BALANCE_UNDERFUNDED = -5
#   };
#
# ===========================================================================
module Stellar
  class CreateClaimableBalanceResultCode < XDR::Enum
    member :create_claimable_balance_success,        0
    member :create_claimable_balance_malformed,      -1
    member :create_claimable_balance_low_reserve,    -2
    member :create_claimable_balance_no_trust,       -3
    member :create_claimable_balance_not_authorized, -4
    member :create_claimable_balance_underfunded,    -5

    seal
  end
end
