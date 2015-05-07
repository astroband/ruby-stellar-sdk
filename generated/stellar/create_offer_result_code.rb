# Automatically generated on 2015-05-07T07:56:23-07:00
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
#       CREATE_OFFER_MALFORMED = -1,      // generated offer would be invalid
#       CREATE_OFFER_NO_TRUST = -2,       // can't hold what it's buying
#       CREATE_OFFER_NOT_AUTHORIZED = -3, // not authorized to hold what it's buying
#       CREATE_OFFER_LINE_FULL = -4,      // can't receive more of what it's buying
#       CREATE_OFFER_UNDERFUNDED = -5,    // doesn't hold what it's trying to sell
#       CREATE_OFFER_CROSS_SELF = -6,     // would cross an offer from the same user
#   
#       // update errors
#       CREATE_OFFER_NOT_FOUND = -7, // offerID does not match an existing offer
#       CREATE_OFFER_MISMATCH = -8,  // currencies don't match offer
#   
#       CREATE_OFFER_LOW_RESERVE = -9 // not enough funds to create a new Offer
#   };
#
# ===========================================================================
module Stellar
  class CreateOfferResultCode < XDR::Enum
    member :create_offer_success,        0
    member :create_offer_malformed,      -1
    member :create_offer_no_trust,       -2
    member :create_offer_not_authorized, -3
    member :create_offer_line_full,      -4
    member :create_offer_underfunded,    -5
    member :create_offer_cross_self,     -6
    member :create_offer_not_found,      -7
    member :create_offer_mismatch,       -8
    member :create_offer_low_reserve,    -9

    seal
  end
end
