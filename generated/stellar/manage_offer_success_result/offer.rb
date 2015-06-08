# Automatically generated on 2015-06-08T11:39:15-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union switch (ManageOfferEffect effect)
#       {
#       case MANAGE_OFFER_CREATED:
#       case MANAGE_OFFER_UPDATED:
#           OfferEntry offer;
#       default:
#           void;
#       }
#
# ===========================================================================
module Stellar
  class ManageOfferSuccessResult
    class Offer < XDR::Union
      switch_on ManageOfferEffect, :effect

      switch :manage_offer_created, :offer
      switch :manage_offer_updated, :offer
      switch :default

      attribute :offer, OfferEntry
    end
  end
end
