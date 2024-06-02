# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum EndSponsoringFutureReservesResultCode
#   {
#       // codes considered as "success" for the operation
#       END_SPONSORING_FUTURE_RESERVES_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       END_SPONSORING_FUTURE_RESERVES_NOT_SPONSORED = -1
#   };
#
# ===========================================================================
module Stellar
  class EndSponsoringFutureReservesResultCode < XDR::Enum
    member :end_sponsoring_future_reserves_success,       0
    member :end_sponsoring_future_reserves_not_sponsored, -1

    seal
  end
end
