# Automatically generated on 2015-05-13T15:00:04-07:00
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

    switch :path_payment_success, :success
    switch :default

    attribute :success, Success
  end
end
