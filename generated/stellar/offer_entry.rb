# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct OfferEntry
#   {
#       AccountID sellerID;
#       int64 offerID;
#       Asset selling; // A
#       Asset buying;  // B
#       int64 amount;  // amount of A
#   
#       /* price for this offer:
#           price of A in terms of B
#           price=AmountB/AmountA=priceNumerator/priceDenominator
#           price is after fees
#       */
#       Price price;
#       uint32 flags; // see OfferEntryFlags
#   
#       // reserved for future use
#       union switch (int v)
#       {
#       case 0:
#           void;
#       }
#       ext;
#   };
#
# ===========================================================================
module Stellar
  class OfferEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :seller_id, AccountID
    attribute :offer_id,  Int64
    attribute :selling,   Asset
    attribute :buying,    Asset
    attribute :amount,    Int64
    attribute :price,     Price
    attribute :flags,     Uint32
    attribute :ext,       Ext
  end
end
