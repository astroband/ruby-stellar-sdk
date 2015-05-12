# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum PaymentResultCode
#   {
#       // codes considered as "success" for the operation
#       PAYMENT_SUCCESS = 0,       // simple payment success
#       PAYMENT_SUCCESS_MULTI = 1, // multi-path payment success
#   
#       // codes considered as "failure" for the operation
#       PAYMENT_MALFORMED = -1,      // bad input
#       PAYMENT_UNDERFUNDED = -2,    // not enough funds in source account
#       PAYMENT_NO_DESTINATION = -3, // destination account does not exist
#       PAYMENT_NO_TRUST = -4, // destination missing a trust line for currency
#       PAYMENT_NOT_AUTHORIZED = -5, // destination not authorized to hold currency
#       PAYMENT_LINE_FULL = -6,      // destination would go above their limit
#       PAYMENT_TOO_FEW_OFFERS = -7, // not enough offers to satisfy path payment
#       PAYMENT_OVER_SENDMAX = -8,   // multi-path payment could not satisfy sendmax
#       PAYMENT_LOW_RESERVE = -9 // would create an account below the min reserve
#   };
#
# ===========================================================================
module Stellar
  class PaymentResultCode < XDR::Enum
    member :payment_success,        0
    member :payment_success_multi,  1
    member :payment_malformed,      -1
    member :payment_underfunded,    -2
    member :payment_no_destination, -3
    member :payment_no_trust,       -4
    member :payment_not_authorized, -5
    member :payment_line_full,      -6
    member :payment_too_few_offers, -7
    member :payment_over_sendmax,   -8
    member :payment_low_reserve,    -9

    seal
  end
end
