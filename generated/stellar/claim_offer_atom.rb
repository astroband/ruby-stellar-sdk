# Automatically generated on 2015-04-07T10:52:07-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct ClaimOfferAtom
#   {
#       // emited to identify the offer
#       AccountID offerOwner; // Account that owns the offer
#       uint64 offerID;
#   
#       // amount and currency taken from the owner
#       Currency currencyClaimed;
#       int64 amountClaimed;
#   
#       // should we also include the amount that the owner gets in return?
#   };
#
# ===========================================================================
module Stellar
  class ClaimOfferAtom < XDR::Struct
    attribute :offer_owner,      AccountID
    attribute :offer_id,         Uint64
    attribute :currency_claimed, Currency
    attribute :amount_claimed,   Int64
  end
end
