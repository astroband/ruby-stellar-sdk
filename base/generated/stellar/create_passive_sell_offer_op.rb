# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct CreatePassiveSellOfferOp
#   {
#       Asset selling; // A
#       Asset buying;  // B
#       int64 amount;  // amount taker gets. if set to 0, delete the offer
#       Price price;   // cost of A in terms of B
#   };
#
# ===========================================================================
module Stellar
  class CreatePassiveSellOfferOp < XDR::Struct
    attribute :selling, Asset
    attribute :buying,  Asset
    attribute :amount,  Int64
    attribute :price,   Price
  end
end
