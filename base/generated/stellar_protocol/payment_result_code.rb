# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum PaymentResultCode
#   {
#       // codes considered as "success" for the operation
#       PAYMENT_SUCCESS = 0, // payment successfully completed
#   
#       // codes considered as "failure" for the operation
#       PAYMENT_MALFORMED = -1,          // bad input
#       PAYMENT_UNDERFUNDED = -2,        // not enough funds in source account
#       PAYMENT_SRC_NO_TRUST = -3,       // no trust line on source account
#       PAYMENT_SRC_NOT_AUTHORIZED = -4, // source not authorized to transfer
#       PAYMENT_NO_DESTINATION = -5,     // destination account does not exist
#       PAYMENT_NO_TRUST = -6,       // destination missing a trust line for asset
#       PAYMENT_NOT_AUTHORIZED = -7, // destination not authorized to hold asset
#       PAYMENT_LINE_FULL = -8,      // destination would go above their limit
#       PAYMENT_NO_ISSUER = -9       // missing issuer on asset
#   };
#
# ===========================================================================
module StellarProtocol
  class PaymentResultCode < XDR::Enum
    member :payment_success,            0
    member :payment_malformed,          -1
    member :payment_underfunded,        -2
    member :payment_src_no_trust,       -3
    member :payment_src_not_authorized, -4
    member :payment_no_destination,     -5
    member :payment_no_trust,           -6
    member :payment_not_authorized,     -7
    member :payment_line_full,          -8
    member :payment_no_issuer,          -9

    seal
  end
end
