# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum PathPaymentResultCode
#   {
#       // codes considered as "success" for the operation
#       PATH_PAYMENT_SUCCESS = 0, // success
#   
#       // codes considered as "failure" for the operation
#       PATH_PAYMENT_MALFORMED = -1,      // bad input
#       PATH_PAYMENT_UNDERFUNDED = -2,    // not enough funds in source account
#       PATH_PAYMENT_NO_DESTINATION = -3, // destination account does not exist
#       PATH_PAYMENT_NO_TRUST = -4, // destination missing a trust line for currency
#       PATH_PAYMENT_NOT_AUTHORIZED =
#           -5,                      // destination not authorized to hold currency
#       PATH_PAYMENT_LINE_FULL = -6, // destination would go above their limit
#       PATH_PAYMENT_TOO_FEW_OFFERS = -7, // not enough offers to satisfy path
#       PATH_PAYMENT_OVER_SENDMAX = -8    // could not satisfy sendmax
#   };
#
# ===========================================================================
module Stellar
  class PathPaymentResultCode < XDR::Enum
    member :path_payment_success,        0
    member :path_payment_malformed,      -1
    member :path_payment_underfunded,    -2
    member :path_payment_no_destination, -3
    member :path_payment_no_trust,       -4
    member :path_payment_not_authorized, -5
    member :path_payment_line_full,      -6
    member :path_payment_too_few_offers, -7
    member :path_payment_over_sendmax,   -8

    seal
  end
end
