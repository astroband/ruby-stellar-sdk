# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ManageOfferResult switch (ManageOfferResultCode code)
#   {
#   case MANAGE_OFFER_SUCCESS:
#       ManageOfferSuccessResult success;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ManageOfferResult < XDR::Union
    switch_on ManageOfferResultCode, :code

    switch :manage_offer_success, :success
    switch :default

    attribute :success, ManageOfferSuccessResult
  end
end
