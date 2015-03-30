# Automatically generated on 2015-03-30T09:46:32-07:00
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
