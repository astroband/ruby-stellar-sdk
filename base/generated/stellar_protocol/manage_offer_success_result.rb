# This code was automatically generated using xdrgen
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
module StellarProtocol
  class ManageOfferSuccessResult < XDR::Struct
    include XDR::Namespace

    autoload :Offer

    attribute :offers_claimed, XDR::VarArray[ClaimOfferAtom]
    attribute :offer,          Offer
  end
end
