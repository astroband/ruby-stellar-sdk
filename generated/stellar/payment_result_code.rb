# Automatically generated on 2015-03-31T14:32:44-07:00
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
#       PAYMENT_UNDERFUNDED = 2,    // not enough funds in source account
#       PAYMENT_NO_DESTINATION = 3, // destination account does not exist
#       PAYMENT_NO_TRUST = 4,       // destination missing a trust line for currency
#       PAYMENT_NOT_AUTHORIZED = 5, // destination not authorized to hold currency
#       PAYMENT_LINE_FULL = 6,      // destination would go above their limit
#       PAYMENT_OVER_SENDMAX = 7,   // multi-path payment could not satisfy sendmax
#       PAYMENT_LOW_RESERVE = 8     // would create an account below the min reserve
#   };
#
# ===========================================================================
module Stellar
  class PaymentResultCode < XDR::Enum
    member :payment_success,        0
    member :payment_success_multi,  1
    member :payment_underfunded,    2
    member :payment_no_destination, 3
    member :payment_no_trust,       4
    member :payment_not_authorized, 5
    member :payment_line_full,      6
    member :payment_over_sendmax,   7
    member :payment_low_reserve,    8

    seal
  end
end
