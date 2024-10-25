# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union BeginSponsoringFutureReservesResult switch (
#       BeginSponsoringFutureReservesResultCode code)
#   {
#   case BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS:
#       void;
#   case BEGIN_SPONSORING_FUTURE_RESERVES_MALFORMED:
#   case BEGIN_SPONSORING_FUTURE_RESERVES_ALREADY_SPONSORED:
#   case BEGIN_SPONSORING_FUTURE_RESERVES_RECURSIVE:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class BeginSponsoringFutureReservesResult < XDR::Union
    switch_on BeginSponsoringFutureReservesResultCode, :code

    switch :begin_sponsoring_future_reserves_success
    switch :begin_sponsoring_future_reserves_malformed
    switch :begin_sponsoring_future_reserves_already_sponsored
    switch :begin_sponsoring_future_reserves_recursive

  end
end
