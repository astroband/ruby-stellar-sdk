# Automatically generated on 2015-06-08T11:39:15-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum ManageOfferEffect
#   {
#       MANAGE_OFFER_CREATED = 0,
#       MANAGE_OFFER_UPDATED = 1,
#       MANAGE_OFFER_DELETED = 2
#   };
#
# ===========================================================================
module Stellar
  class ManageOfferEffect < XDR::Enum
    member :manage_offer_created, 0
    member :manage_offer_updated, 1
    member :manage_offer_deleted, 2

    seal
  end
end
