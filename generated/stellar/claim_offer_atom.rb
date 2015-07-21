# This code was automatically generated using xdrgen
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
#       // amount and asset taken from the owner
#       Asset assetClaimed;
#       int64 amountClaimed;
#   
#       // amount and assetsent to the owner
#       Asset assetSend;
#       int64 amountSend;
#   };
#
# ===========================================================================
module Stellar
  class ClaimOfferAtom < XDR::Struct
    attribute :offer_owner,    AccountID
    attribute :offer_id,       Uint64
    attribute :asset_claimed,  Asset
    attribute :amount_claimed, Int64
    attribute :asset_send,     Asset
    attribute :amount_send,    Int64
  end
end
