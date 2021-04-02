# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ClawbackClaimableBalanceResultCode
#   {
#       // codes considered as "success" for the operation
#       CLAWBACK_CLAIMABLE_BALANCE_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       CLAWBACK_CLAIMABLE_BALANCE_DOES_NOT_EXIST = -1,
#       CLAWBACK_CLAIMABLE_BALANCE_NOT_ISSUER = -2,
#       CLAWBACK_CLAIMABLE_BALANCE_NOT_CLAWBACK_ENABLED = -3
#   };
#
# ===========================================================================
module Stellar
  class ClawbackClaimableBalanceResultCode < XDR::Enum
    member :clawback_claimable_balance_success,              0
    member :clawback_claimable_balance_does_not_exist,       -1
    member :clawback_claimable_balance_not_issuer,           -2
    member :clawback_claimable_balance_not_clawback_enabled, -3

    seal
  end
end
