# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct CreateOfferSuccessResult
#   {
#       // offers that got claimed while creating this offer
#       ClaimOfferAtom offersClaimed<>;
#   
#       union switch (CreateOfferEffect effect)
#       {
#       case CREATE_OFFER_CREATED:
#       case CREATE_OFFER_UPDATED:
#           OfferEntry offer;
#       default:
#           void;
#       }
#       offer;
#   };
#
# ===========================================================================
module Stellar
  class CreateOfferSuccessResult < XDR::Struct
    include XDR::Namespace

    autoload :Offer

    attribute :offers_claimed, XDR::VarArray[ClaimOfferAtom]
    attribute :offer,          Offer
  end
end
