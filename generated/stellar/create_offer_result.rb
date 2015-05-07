# Automatically generated on 2015-05-07T07:56:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union CreateOfferResult switch (CreateOfferResultCode code)
#   {
#   case CREATE_OFFER_SUCCESS:
#       CreateOfferSuccessResult success;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class CreateOfferResult < XDR::Union
    switch_on CreateOfferResultCode, :code

    switch :create_offer_success, :success
    switch :default

    attribute :success, CreateOfferSuccessResult
  end
end
