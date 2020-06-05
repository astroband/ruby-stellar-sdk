# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ManageSellOfferResultCode
#   {
#       // codes considered as "success" for the operation
#       MANAGE_SELL_OFFER_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       MANAGE_SELL_OFFER_MALFORMED = -1,     // generated offer would be invalid
#       MANAGE_SELL_OFFER_SELL_NO_TRUST = -2, // no trust line for what we're selling
#       MANAGE_SELL_OFFER_BUY_NO_TRUST = -3,  // no trust line for what we're buying
#       MANAGE_SELL_OFFER_SELL_NOT_AUTHORIZED = -4, // not authorized to sell
#       MANAGE_SELL_OFFER_BUY_NOT_AUTHORIZED = -5,  // not authorized to buy
#       MANAGE_SELL_OFFER_LINE_FULL = -6,      // can't receive more of what it's buying
#       MANAGE_SELL_OFFER_UNDERFUNDED = -7,    // doesn't hold what it's trying to sell
#       MANAGE_SELL_OFFER_CROSS_SELF = -8,     // would cross an offer from the same user
#       MANAGE_SELL_OFFER_SELL_NO_ISSUER = -9, // no issuer for what we're selling
#       MANAGE_SELL_OFFER_BUY_NO_ISSUER = -10, // no issuer for what we're buying
#   
#       // update errors
#       MANAGE_SELL_OFFER_NOT_FOUND = -11, // offerID does not match an existing offer
#   
#       MANAGE_SELL_OFFER_LOW_RESERVE = -12 // not enough funds to create a new Offer
#   };
#
# ===========================================================================
module Stellar
  class ManageSellOfferResultCode < XDR::Enum
    member :manage_sell_offer_success,             0
    member :manage_sell_offer_malformed,           -1
    member :manage_sell_offer_sell_no_trust,       -2
    member :manage_sell_offer_buy_no_trust,        -3
    member :manage_sell_offer_sell_not_authorized, -4
    member :manage_sell_offer_buy_not_authorized,  -5
    member :manage_sell_offer_line_full,           -6
    member :manage_sell_offer_underfunded,         -7
    member :manage_sell_offer_cross_self,          -8
    member :manage_sell_offer_sell_no_issuer,      -9
    member :manage_sell_offer_buy_no_issuer,       -10
    member :manage_sell_offer_not_found,           -11
    member :manage_sell_offer_low_reserve,         -12

    seal
  end
end
