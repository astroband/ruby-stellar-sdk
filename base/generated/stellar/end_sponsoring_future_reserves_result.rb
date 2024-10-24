# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union EndSponsoringFutureReservesResult switch (
#       EndSponsoringFutureReservesResultCode code)
#   {
#   case END_SPONSORING_FUTURE_RESERVES_SUCCESS:
#       void;
#   case END_SPONSORING_FUTURE_RESERVES_NOT_SPONSORED:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class EndSponsoringFutureReservesResult < XDR::Union
    switch_on EndSponsoringFutureReservesResultCode, :code

    switch :end_sponsoring_future_reserves_success
    switch :end_sponsoring_future_reserves_not_sponsored

  end
end
