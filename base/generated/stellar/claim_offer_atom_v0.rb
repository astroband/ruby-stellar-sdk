# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ClaimOfferAtomV0
#   {
#       // emitted to identify the offer
#       uint256 sellerEd25519; // Account that owns the offer
#       int64 offerID;
#
#       // amount and asset taken from the owner
#       Asset assetSold;
#       int64 amountSold;
#
#       // amount and asset sent to the owner
#       Asset assetBought;
#       int64 amountBought;
#   };
#
# ===========================================================================
module Stellar
  class ClaimOfferAtomV0 < XDR::Struct
    attribute :seller_ed25519, Uint256
    attribute :offer_id,       Int64
    attribute :asset_sold,     Asset
    attribute :amount_sold,    Int64
    attribute :asset_bought,   Asset
    attribute :amount_bought,  Int64
  end
end
