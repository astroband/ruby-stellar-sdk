# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union PaymentResult switch (PaymentResultCode code)
#   {
#   case PAYMENT_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class PaymentResult < XDR::Union
    switch_on PaymentResultCode, :code

    switch :payment_success
    switch :default

  end
end
