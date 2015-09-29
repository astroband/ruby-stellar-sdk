# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union PathPaymentResult switch (PathPaymentResultCode code)
#   {
#   case PATH_PAYMENT_SUCCESS:
#       struct
#       {
#           ClaimOfferAtom offers<>;
#           SimplePaymentResult last;
#       } success;
#   case PATH_PAYMENT_NO_ISSUER:
#       Asset noIssuer; // the asset that caused the error
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class PathPaymentResult < XDR::Union
    include XDR::Namespace

    autoload :Success

    switch_on PathPaymentResultCode, :code

    switch :path_payment_success,   :success
    switch :path_payment_no_issuer, :no_issuer
    switch :default

    attribute :success,   Success
    attribute :no_issuer, Asset
  end
end
