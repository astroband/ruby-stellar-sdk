# This code was automatically generated using xdrgen
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
