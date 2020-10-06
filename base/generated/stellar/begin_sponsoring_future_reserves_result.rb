# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union BeginSponsoringFutureReservesResult switch (BeginSponsoringFutureReservesResultCode code)
#   {
#   case BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class BeginSponsoringFutureReservesResult < XDR::Union
    switch_on BeginSponsoringFutureReservesResultCode, :code

    switch :begin_sponsoring_future_reserves_success
    switch :default

  end
end
