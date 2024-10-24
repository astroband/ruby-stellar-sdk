# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ManageBuyOfferResult switch (ManageBuyOfferResultCode code)
#   {
#   case MANAGE_BUY_OFFER_SUCCESS:
#       ManageOfferSuccessResult success;
#   case MANAGE_BUY_OFFER_MALFORMED:
#   case MANAGE_BUY_OFFER_SELL_NO_TRUST:
#   case MANAGE_BUY_OFFER_BUY_NO_TRUST:
#   case MANAGE_BUY_OFFER_SELL_NOT_AUTHORIZED:
#   case MANAGE_BUY_OFFER_BUY_NOT_AUTHORIZED:
#   case MANAGE_BUY_OFFER_LINE_FULL:
#   case MANAGE_BUY_OFFER_UNDERFUNDED:
#   case MANAGE_BUY_OFFER_CROSS_SELF:
#   case MANAGE_BUY_OFFER_SELL_NO_ISSUER:
#   case MANAGE_BUY_OFFER_BUY_NO_ISSUER:
#   case MANAGE_BUY_OFFER_NOT_FOUND:
#   case MANAGE_BUY_OFFER_LOW_RESERVE:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ManageBuyOfferResult < XDR::Union
    switch_on ManageBuyOfferResultCode, :code

    switch :manage_buy_offer_success,           :success
    switch :manage_buy_offer_malformed
    switch :manage_buy_offer_sell_no_trust
    switch :manage_buy_offer_buy_no_trust
    switch :manage_buy_offer_sell_not_authorized
    switch :manage_buy_offer_buy_not_authorized
    switch :manage_buy_offer_line_full
    switch :manage_buy_offer_underfunded
    switch :manage_buy_offer_cross_self
    switch :manage_buy_offer_sell_no_issuer
    switch :manage_buy_offer_buy_no_issuer
    switch :manage_buy_offer_not_found
    switch :manage_buy_offer_low_reserve

    attribute :success, ManageOfferSuccessResult
  end
end
