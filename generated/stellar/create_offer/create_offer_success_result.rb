# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module CreateOffer
    class CreateOfferSuccessResult < XDR::Struct
      autoload :Offer, "#{__dir__}/create_offer_success_result/offer"
                                 
      attribute :offers_claimed, XDR::VarArray[ClaimOfferAtom]
      attribute :offer,          Offer
    end
  end
end
