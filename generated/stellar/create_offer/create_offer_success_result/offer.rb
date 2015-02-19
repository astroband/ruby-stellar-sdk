# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module CreateOffer
    class CreateOfferSuccessResult
      class Offer < XDR::Union


        switch_on CreateOfferEffect, :effect
                                          
        switch CreateOfferEffect.created, :offer_created
                                                  switch :default
                                  
        attribute :offer_created, OfferEntry
      end
    end
  end
end
