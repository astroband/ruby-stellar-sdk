# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct PaymentOp
#   {
#       MuxedAccount destination; // recipient of the payment
#       Asset asset;              // what they end up with
#       int64 amount;             // amount they end up with
#   };
#
# ===========================================================================
module Stellar
  class PaymentOp < XDR::Struct
    attribute :destination, MuxedAccount
    attribute :asset,       Asset
    attribute :amount,      Int64
  end
end
