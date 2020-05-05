# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ManageBuyOfferResult switch (ManageBuyOfferResultCode code)
#   {
#   case MANAGE_BUY_OFFER_SUCCESS:
#       ManageOfferSuccessResult success;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ManageBuyOfferResult < XDR::Union
    switch_on ManageBuyOfferResultCode, :code

    switch :manage_buy_offer_success, :success
    switch :default

    attribute :success, ManageOfferSuccessResult
  end
end
