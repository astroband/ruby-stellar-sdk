# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union PathPaymentStrictSendResult switch (PathPaymentStrictSendResultCode code)
#   {
#   case PATH_PAYMENT_STRICT_SEND_SUCCESS:
#       struct
#       {
#           ClaimAtom offers<>;
#           SimplePaymentResult last;
#       } success;
#   case PATH_PAYMENT_STRICT_SEND_MALFORMED:
#   case PATH_PAYMENT_STRICT_SEND_UNDERFUNDED:
#   case PATH_PAYMENT_STRICT_SEND_SRC_NO_TRUST:
#   case PATH_PAYMENT_STRICT_SEND_SRC_NOT_AUTHORIZED:
#   case PATH_PAYMENT_STRICT_SEND_NO_DESTINATION:
#   case PATH_PAYMENT_STRICT_SEND_NO_TRUST:
#   case PATH_PAYMENT_STRICT_SEND_NOT_AUTHORIZED:
#   case PATH_PAYMENT_STRICT_SEND_LINE_FULL:
#       void;
#   case PATH_PAYMENT_STRICT_SEND_NO_ISSUER:
#       Asset noIssuer; // the asset that caused the error
#   case PATH_PAYMENT_STRICT_SEND_TOO_FEW_OFFERS:
#   case PATH_PAYMENT_STRICT_SEND_OFFER_CROSS_SELF:
#   case PATH_PAYMENT_STRICT_SEND_UNDER_DESTMIN:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class PathPaymentStrictSendResult < XDR::Union
    include XDR::Namespace

    autoload :Success

    switch_on PathPaymentStrictSendResultCode, :code

    switch :path_payment_strict_send_success,          :success
    switch :path_payment_strict_send_malformed
    switch :path_payment_strict_send_underfunded
    switch :path_payment_strict_send_src_no_trust
    switch :path_payment_strict_send_src_not_authorized
    switch :path_payment_strict_send_no_destination
    switch :path_payment_strict_send_no_trust
    switch :path_payment_strict_send_not_authorized
    switch :path_payment_strict_send_line_full
    switch :path_payment_strict_send_no_issuer,        :no_issuer
    switch :path_payment_strict_send_too_few_offers
    switch :path_payment_strict_send_offer_cross_self
    switch :path_payment_strict_send_under_destmin

    attribute :success,   Success
    attribute :no_issuer, Asset
  end
end
