# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ManageSellOfferResult switch (ManageSellOfferResultCode code)
#   {
#   case MANAGE_SELL_OFFER_SUCCESS:
#       ManageOfferSuccessResult success;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ManageSellOfferResult < XDR::Union
    switch_on ManageSellOfferResultCode, :code

    switch :manage_sell_offer_success, :success
    switch :default

    attribute :success, ManageOfferSuccessResult
  end
end
