# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum RevokeSponsorshipResultCode
#   {
#       // codes considered as "success" for the operation
#       REVOKE_SPONSORSHIP_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       REVOKE_SPONSORSHIP_DOES_NOT_EXIST = -1,
#       REVOKE_SPONSORSHIP_NOT_SPONSOR = -2,
#       REVOKE_SPONSORSHIP_LOW_RESERVE = -3,
#       REVOKE_SPONSORSHIP_ONLY_TRANSFERABLE = -4
#   };
#
# ===========================================================================
module Stellar
  class RevokeSponsorshipResultCode < XDR::Enum
    member :revoke_sponsorship_success,           0
    member :revoke_sponsorship_does_not_exist,    -1
    member :revoke_sponsorship_not_sponsor,       -2
    member :revoke_sponsorship_low_reserve,       -3
    member :revoke_sponsorship_only_transferable, -4

    seal
  end
end
