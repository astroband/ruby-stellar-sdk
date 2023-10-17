# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct PathPaymentStrictSendOp
#   {
#       Asset sendAsset;  // asset we pay with
#       int64 sendAmount; // amount of sendAsset to send (excluding fees)
#
#       MuxedAccount destination; // recipient of the payment
#       Asset destAsset;          // what they end up with
#       int64 destMin;            // the minimum amount of dest asset to
#                                 // be received
#                                 // The operation will fail if it can't be met
#
#       Asset path<5>; // additional hops it must go through to get there
#   };
#
# ===========================================================================
module Stellar
  class PathPaymentStrictSendOp < XDR::Struct
    attribute :send_asset,  Asset
    attribute :send_amount, Int64
    attribute :destination, MuxedAccount
    attribute :dest_asset,  Asset
    attribute :dest_min,    Int64
    attribute :path,        XDR::VarArray[Asset, 5]
  end
end
