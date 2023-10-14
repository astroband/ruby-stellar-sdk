# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union PathPaymentStrictReceiveResult switch (
#       PathPaymentStrictReceiveResultCode code)
#   {
#   case PATH_PAYMENT_STRICT_RECEIVE_SUCCESS:
#       struct
#       {
#           ClaimAtom offers<>;
#           SimplePaymentResult last;
#       } success;
#   case PATH_PAYMENT_STRICT_RECEIVE_MALFORMED:
#   case PATH_PAYMENT_STRICT_RECEIVE_UNDERFUNDED:
#   case PATH_PAYMENT_STRICT_RECEIVE_SRC_NO_TRUST:
#   case PATH_PAYMENT_STRICT_RECEIVE_SRC_NOT_AUTHORIZED:
#   case PATH_PAYMENT_STRICT_RECEIVE_NO_DESTINATION:
#   case PATH_PAYMENT_STRICT_RECEIVE_NO_TRUST:
#   case PATH_PAYMENT_STRICT_RECEIVE_NOT_AUTHORIZED:
#   case PATH_PAYMENT_STRICT_RECEIVE_LINE_FULL:
#       void;
#   case PATH_PAYMENT_STRICT_RECEIVE_NO_ISSUER:
#       Asset noIssuer; // the asset that caused the error
#   case PATH_PAYMENT_STRICT_RECEIVE_TOO_FEW_OFFERS:
#   case PATH_PAYMENT_STRICT_RECEIVE_OFFER_CROSS_SELF:
#   case PATH_PAYMENT_STRICT_RECEIVE_OVER_SENDMAX:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class PathPaymentStrictReceiveResult < XDR::Union
    include XDR::Namespace

    autoload :Success

    switch_on PathPaymentStrictReceiveResultCode, :code

    switch :path_payment_strict_receive_success,          :success
    switch :path_payment_strict_receive_malformed
    switch :path_payment_strict_receive_underfunded
    switch :path_payment_strict_receive_src_no_trust
    switch :path_payment_strict_receive_src_not_authorized
    switch :path_payment_strict_receive_no_destination
    switch :path_payment_strict_receive_no_trust
    switch :path_payment_strict_receive_not_authorized
    switch :path_payment_strict_receive_line_full
    switch :path_payment_strict_receive_no_issuer,        :no_issuer
    switch :path_payment_strict_receive_too_few_offers
    switch :path_payment_strict_receive_offer_cross_self
    switch :path_payment_strict_receive_over_sendmax

    attribute :success,   Success
    attribute :no_issuer, Asset
  end
end
