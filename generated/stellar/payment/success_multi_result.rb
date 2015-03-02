# Automatically generated from xdr/Stellar-transaction.x
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
