# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct PaymentSuccessMultiResult
#   {
#       ClaimOfferAtom offers<>;
#       SimplePaymentResult last;
#   };
#
# ===========================================================================
module Stellar
  class PaymentSuccessMultiResult < XDR::Struct
    attribute :offers, XDR::VarArray[ClaimOfferAtom]
    attribute :last,   SimplePaymentResult
  end
end
