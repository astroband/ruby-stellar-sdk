# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ClaimableBalanceFlags
#   {
#       // If set, the issuer account of the asset held by the claimable balance may
#       // clawback the claimable balance
#       CLAIMABLE_BALANCE_CLAWBACK_ENABLED_FLAG = 0x1
#   };
#
# ===========================================================================
module StellarProtocol
  class ClaimableBalanceFlags < XDR::Enum
    member :claimable_balance_clawback_enabled_flag, 1

    seal
  end
end
