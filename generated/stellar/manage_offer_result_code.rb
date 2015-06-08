# Automatically generated on 2015-06-08T11:39:15-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum ManageOfferResultCode
#   {
#       // codes considered as "success" for the operation
#       MANAGE_OFFER_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       MANAGE_OFFER_MALFORMED = -1,      // generated offer would be invalid
#       MANAGE_OFFER_NO_TRUST = -2,       // can't hold what it's buying
#       MANAGE_OFFER_NOT_AUTHORIZED = -3, // not authorized to sell or buy
#       MANAGE_OFFER_LINE_FULL = -4,      // can't receive more of what it's buying
#       MANAGE_OFFER_UNDERFUNDED = -5,    // doesn't hold what it's trying to sell
#       MANAGE_OFFER_CROSS_SELF = -6,     // would cross an offer from the same user
#   
#       // update errors
#       MANAGE_OFFER_NOT_FOUND = -7, // offerID does not match an existing offer
#       MANAGE_OFFER_MISMATCH = -8,  // currencies don't match offer
#   
#       MANAGE_OFFER_LOW_RESERVE = -9 // not enough funds to create a new Offer
#   };
#
# ===========================================================================
module Stellar
  class ManageOfferResultCode < XDR::Enum
    member :manage_offer_success,        0
    member :manage_offer_malformed,      -1
    member :manage_offer_no_trust,       -2
    member :manage_offer_not_authorized, -3
    member :manage_offer_line_full,      -4
    member :manage_offer_underfunded,    -5
    member :manage_offer_cross_self,     -6
    member :manage_offer_not_found,      -7
    member :manage_offer_mismatch,       -8
    member :manage_offer_low_reserve,    -9

    seal
  end
end
