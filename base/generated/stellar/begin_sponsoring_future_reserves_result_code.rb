# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum BeginSponsoringFutureReservesResultCode
#   {
#       // codes considered as "success" for the operation
#       BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       BEGIN_SPONSORING_FUTURE_RESERVES_MALFORMED = -1,
#       BEGIN_SPONSORING_FUTURE_RESERVES_ALREADY_SPONSORED = -2,
#       BEGIN_SPONSORING_FUTURE_RESERVES_RECURSIVE = -3
#   };
#
# ===========================================================================
module Stellar
  class BeginSponsoringFutureReservesResultCode < XDR::Enum
    member :begin_sponsoring_future_reserves_success,           0
    member :begin_sponsoring_future_reserves_malformed,         -1
    member :begin_sponsoring_future_reserves_already_sponsored, -2
    member :begin_sponsoring_future_reserves_recursive,         -3

    seal
  end
end
