# Automatically generated on 2015-06-09T15:04:05-07:00
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
#       // amount and currencysent to the owner
#       Currency currencySend;
#       int64 amountSend;
#   };
#
# ===========================================================================
module Stellar
  class ClaimOfferAtom < XDR::Struct
    attribute :offer_owner,      AccountID
    attribute :offer_id,         Uint64
    attribute :currency_claimed, Currency
    attribute :amount_claimed,   Int64
    attribute :currency_send,    Currency
    attribute :amount_send,      Int64
  end
end
