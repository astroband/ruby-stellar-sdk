# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum CreateOfferEffect
#   {
#       CREATE_OFFER_CREATED = 0,
#       CREATE_OFFER_UPDATED = 1,
#       CREATE_OFFER_DELETED = 2
#   };
#
# ===========================================================================
module Stellar
  class CreateOfferEffect < XDR::Enum
    member :create_offer_created, 0
    member :create_offer_updated, 1
    member :create_offer_deleted, 2

    seal
  end
end
