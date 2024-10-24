# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union PaymentResult switch (PaymentResultCode code)
#   {
#   case PAYMENT_SUCCESS:
#       void;
#   case PAYMENT_MALFORMED:
#   case PAYMENT_UNDERFUNDED:
#   case PAYMENT_SRC_NO_TRUST:
#   case PAYMENT_SRC_NOT_AUTHORIZED:
#   case PAYMENT_NO_DESTINATION:
#   case PAYMENT_NO_TRUST:
#   case PAYMENT_NOT_AUTHORIZED:
#   case PAYMENT_LINE_FULL:
#   case PAYMENT_NO_ISSUER:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class PaymentResult < XDR::Union
    switch_on PaymentResultCode, :code

    switch :payment_success
    switch :payment_malformed
    switch :payment_underfunded
    switch :payment_src_no_trust
    switch :payment_src_not_authorized
    switch :payment_no_destination
    switch :payment_no_trust
    switch :payment_not_authorized
    switch :payment_line_full
    switch :payment_no_issuer

  end
end
