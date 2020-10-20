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
#           ClaimOfferAtom offers<>;
#           SimplePaymentResult last;
#       } success;
#   case PATH_PAYMENT_STRICT_RECEIVE_NO_ISSUER:
#       Asset noIssuer; // the asset that caused the error
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class PathPaymentStrictReceiveResult < XDR::Union
    include XDR::Namespace

    autoload :Success

    switch_on PathPaymentStrictReceiveResultCode, :code

    switch :path_payment_strict_receive_success,   :success
    switch :path_payment_strict_receive_no_issuer, :no_issuer
    switch :default

    attribute :success,   Success
    attribute :no_issuer, Asset
  end
end
