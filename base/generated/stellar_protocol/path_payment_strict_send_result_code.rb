# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum PathPaymentStrictSendResultCode
#   {
#       // codes considered as "success" for the operation
#       PATH_PAYMENT_STRICT_SEND_SUCCESS = 0, // success
#   
#       // codes considered as "failure" for the operation
#       PATH_PAYMENT_STRICT_SEND_MALFORMED = -1, // bad input
#       PATH_PAYMENT_STRICT_SEND_UNDERFUNDED =
#           -2, // not enough funds in source account
#       PATH_PAYMENT_STRICT_SEND_SRC_NO_TRUST =
#           -3, // no trust line on source account
#       PATH_PAYMENT_STRICT_SEND_SRC_NOT_AUTHORIZED =
#           -4, // source not authorized to transfer
#       PATH_PAYMENT_STRICT_SEND_NO_DESTINATION =
#           -5, // destination account does not exist
#       PATH_PAYMENT_STRICT_SEND_NO_TRUST =
#           -6, // dest missing a trust line for asset
#       PATH_PAYMENT_STRICT_SEND_NOT_AUTHORIZED =
#           -7, // dest not authorized to hold asset
#       PATH_PAYMENT_STRICT_SEND_LINE_FULL = -8, // dest would go above their limit
#       PATH_PAYMENT_STRICT_SEND_NO_ISSUER = -9, // missing issuer on one asset
#       PATH_PAYMENT_STRICT_SEND_TOO_FEW_OFFERS =
#           -10, // not enough offers to satisfy path
#       PATH_PAYMENT_STRICT_SEND_OFFER_CROSS_SELF =
#           -11, // would cross one of its own offers
#       PATH_PAYMENT_STRICT_SEND_UNDER_DESTMIN = -12 // could not satisfy destMin
#   };
#
# ===========================================================================
module StellarProtocol
  class PathPaymentStrictSendResultCode < XDR::Enum
    member :path_payment_strict_send_success,            0
    member :path_payment_strict_send_malformed,          -1
    member :path_payment_strict_send_underfunded,        -2
    member :path_payment_strict_send_src_no_trust,       -3
    member :path_payment_strict_send_src_not_authorized, -4
    member :path_payment_strict_send_no_destination,     -5
    member :path_payment_strict_send_no_trust,           -6
    member :path_payment_strict_send_not_authorized,     -7
    member :path_payment_strict_send_line_full,          -8
    member :path_payment_strict_send_no_issuer,          -9
    member :path_payment_strict_send_too_few_offers,     -10
    member :path_payment_strict_send_offer_cross_self,   -11
    member :path_payment_strict_send_under_destmin,      -12

    seal
  end
end
