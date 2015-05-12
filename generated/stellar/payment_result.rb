# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union PaymentResult switch (PaymentResultCode code)
#   {
#   case PAYMENT_SUCCESS:
#       void;
#   case PAYMENT_SUCCESS_MULTI:
#       PaymentSuccessMultiResult multi;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class PaymentResult < XDR::Union
    switch_on PaymentResultCode, :code

    switch :payment_success
    switch :payment_success_multi, :multi
    switch :default

    attribute :multi, PaymentSuccessMultiResult
  end
end
