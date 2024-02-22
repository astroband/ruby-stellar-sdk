# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ManageOfferSuccessResult
#   {
#       // offers that got claimed while creating this offer
#       ClaimAtom offersClaimed<>;
#   
#       union switch (ManageOfferEffect effect)
#       {
#       case MANAGE_OFFER_CREATED:
#       case MANAGE_OFFER_UPDATED:
#           OfferEntry offer;
#       case MANAGE_OFFER_DELETED:
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

    attribute :offers_claimed, XDR::VarArray[ClaimAtom]
    attribute :offer,          Offer
  end
end
