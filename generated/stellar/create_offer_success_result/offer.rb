# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union switch (CreateOfferEffect effect)
#       {
#       case CREATE_OFFER_CREATED:
#       case CREATE_OFFER_UPDATED:
#           OfferEntry offer;
#       default:
#           void;
#       }
#
# ===========================================================================
module Stellar
  class CreateOfferSuccessResult
    class Offer < XDR::Union
      switch_on CreateOfferEffect, :effect

      switch :create_offer_created, :offer
      switch :create_offer_updated, :offer
      switch :default

      attribute :offer, OfferEntry
    end
  end
end
