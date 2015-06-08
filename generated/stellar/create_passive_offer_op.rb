# Automatically generated on 2015-06-08T11:39:14-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct CreatePassiveOfferOp
#   {
#       Currency takerGets;
#       Currency takerPays;
#       int64 amount; // amount taker gets. if set to 0, delete the offer
#       Price price;  // =takerPaysAmount/takerGetsAmount
#   };
#
# ===========================================================================
module Stellar
  class CreatePassiveOfferOp < XDR::Struct
    attribute :taker_gets, Currency
    attribute :taker_pays, Currency
    attribute :amount,     Int64
    attribute :price,      Price
  end
end
