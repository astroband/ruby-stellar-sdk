# Automatically generated on 2015-04-07T10:52:07-07:00
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
