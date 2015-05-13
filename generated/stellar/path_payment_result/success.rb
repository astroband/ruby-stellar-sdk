# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           ClaimOfferAtom offers<>;
#           SimplePaymentResult last;
#       }
#
# ===========================================================================
module Stellar
  class PathPaymentResult
    class Success < XDR::Struct
      attribute :offers, XDR::VarArray[ClaimOfferAtom]
      attribute :last,   SimplePaymentResult
    end
  end
end
