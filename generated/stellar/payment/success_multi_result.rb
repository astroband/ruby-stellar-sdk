# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module Payment
    class SuccessMultiResult < XDR::Struct
      attribute :offers, XDR::VarArray[ClaimOfferAtom]
      attribute :last,   SimplePaymentResult
    end
  end
end
