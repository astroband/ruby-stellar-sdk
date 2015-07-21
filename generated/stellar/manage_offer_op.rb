# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ManageOfferOp
#   {
#       Asset selling;
#       Asset buying;
#       int64 amount; // amount being sold. if set to 0, delete the offer
#       Price price;  // price of thing being sold in terms of what you are buying
#   
#       // 0=create a new offer, otherwise edit an existing offer
#       uint64 offerID;
#   };
#
# ===========================================================================
module Stellar
  class ManageOfferOp < XDR::Struct
    attribute :selling,  Asset
    attribute :buying,   Asset
    attribute :amount,   Int64
    attribute :price,    Price
    attribute :offer_id, Uint64
  end
end
