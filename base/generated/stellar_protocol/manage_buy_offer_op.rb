# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ManageBuyOfferOp
#   {
#       Asset selling;
#       Asset buying;
#       int64 buyAmount; // amount being bought. if set to 0, delete the offer
#       Price price;     // price of thing being bought in terms of what you are
#                        // selling
#   
#       // 0=create a new offer, otherwise edit an existing offer
#       int64 offerID;
#   };
#
# ===========================================================================
module StellarProtocol
  class ManageBuyOfferOp < XDR::Struct
    attribute :selling,    Asset
    attribute :buying,     Asset
    attribute :buy_amount, Int64
    attribute :price,      Price
    attribute :offer_id,   Int64
  end
end
