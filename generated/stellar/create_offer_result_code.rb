# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum CreateOfferResultCode
#   {
#       // codes considered as "success" for the operation
#       CREATE_OFFER_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       CREATE_OFFER_NO_TRUST = 1,       // can't hold what it's buying
#       CREATE_OFFER_NOT_AUTHORIZED = 2, // not authorized to hold what it's buying
#       CREATE_OFFER_MALFORMED = 3,      // generated offer would be invalid
#       CREATE_OFFER_UNDERFUNDED = 4,    // doesn't hold what it's trying to sell
#       CREATE_OFFER_CROSS_SELF = 5,     // would cross an offer from the same user
#   
#       // update errors
#       CREATE_OFFER_NOT_FOUND = 6, // offerID does not match an existing offer
#       CREATE_OFFER_MISMATCH = 7,  // currencies don't match offer
#   
#       CREATE_OFFER_LOW_RESERVE = 8 // not enough funds to create a new Offer
#   
#   };
#
# ===========================================================================
module Stellar
  class CreateOfferResultCode < XDR::Enum
    member :create_offer_success,        0
    member :create_offer_no_trust,       1
    member :create_offer_not_authorized, 2
    member :create_offer_malformed,      3
    member :create_offer_underfunded,    4
    member :create_offer_cross_self,     5
    member :create_offer_not_found,      6
    member :create_offer_mismatch,       7
    member :create_offer_low_reserve,    8

    seal
  end
end
