# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SimplePaymentResult
#   {
#       AccountID destination;
#       Asset asset;
#       int64 amount;
#   };
#
# ===========================================================================
module StellarProtocol
  class SimplePaymentResult < XDR::Struct
    attribute :destination, AccountID
    attribute :asset,       Asset
    attribute :amount,      Int64
  end
end
