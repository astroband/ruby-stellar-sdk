# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module CreateOffer
    class CreateOfferSuccessResult < XDR::Struct
      include XDR::Namespace

      autoload :Offer
                                 
      attribute :offers_claimed, XDR::VarArray[ClaimOfferAtom]
      attribute :offer,          Offer
    end
  end
end
