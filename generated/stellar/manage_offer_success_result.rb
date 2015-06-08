# Automatically generated on 2015-06-08T11:39:15-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct ManageOfferSuccessResult
#   {
#       // offers that got claimed while creating this offer
#       ClaimOfferAtom offersClaimed<>;
#   
#       union switch (ManageOfferEffect effect)
#       {
#       case MANAGE_OFFER_CREATED:
#       case MANAGE_OFFER_UPDATED:
#           OfferEntry offer;
#       default:
#           void;
#       }
#       offer;
#   };
#
# ===========================================================================
module Stellar
  class ManageOfferSuccessResult < XDR::Struct
    include XDR::Namespace

    autoload :Offer

    attribute :offers_claimed, XDR::VarArray[ClaimOfferAtom]
    attribute :offer,          Offer
  end
end
