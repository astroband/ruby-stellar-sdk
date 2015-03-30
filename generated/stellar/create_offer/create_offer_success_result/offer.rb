# Automatically generated on 2015-03-30T09:46:32-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module CreateOffer
    class CreateOfferSuccessResult
      class Offer < XDR::Union
        switch_on CreateOfferEffect, :effect

        switch :created, :offer_created
        switch :default

        attribute :offer_created, OfferEntry
      end
    end
  end
end
