# Automatically generated on 2015-06-08T11:39:15-07:00
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
