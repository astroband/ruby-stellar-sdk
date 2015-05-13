# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum PaymentResultCode
#   {
#       // codes considered as "success" for the operation
#       PAYMENT_SUCCESS = 0, // payment successfuly completed
#   
#       // codes considered as "failure" for the operation
#       PAYMENT_MALFORMED = -1,      // bad input
#       PAYMENT_UNDERFUNDED = -2,    // not enough funds in source account
#       PAYMENT_NO_DESTINATION = -3, // destination account does not exist
#       PAYMENT_NO_TRUST = -4, // destination missing a trust line for currency
#       PAYMENT_NOT_AUTHORIZED = -5, // destination not authorized to hold currency
#       PAYMENT_LINE_FULL = -6       // destination would go above their limit
#   };
#
# ===========================================================================
module Stellar
  class PaymentResultCode < XDR::Enum
    member :payment_success,        0
    member :payment_malformed,      -1
    member :payment_underfunded,    -2
    member :payment_no_destination, -3
    member :payment_no_trust,       -4
    member :payment_not_authorized, -5
    member :payment_line_full,      -6

    seal
  end
end
