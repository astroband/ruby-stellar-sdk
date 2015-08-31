# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct PathPaymentOp
#   {
#       Asset sendAsset; // asset we pay with
#       int64 sendMax;   // the maximum amount of sendAsset to
#                        // send (excluding fees).
#                        // The operation will fail if can't be met
#   
#       AccountID destination; // recipient of the payment
#       Asset destAsset;       // what they end up with
#       int64 destAmount;      // amount they end up with
#   
#       Asset path<5>; // additional hops it must go through to get there
#   };
#
# ===========================================================================
module Stellar
  class PathPaymentOp < XDR::Struct
    attribute :send_asset,  Asset
    attribute :send_max,    Int64
    attribute :destination, AccountID
    attribute :dest_asset,  Asset
    attribute :dest_amount, Int64
    attribute :path,        XDR::VarArray[Asset, 5]
  end
end
