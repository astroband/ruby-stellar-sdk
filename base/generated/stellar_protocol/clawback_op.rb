# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ClawbackOp
#   {
#       Asset asset;
#       MuxedAccount from;
#       int64 amount;
#   };
#
# ===========================================================================
module StellarProtocol
  class ClawbackOp < XDR::Struct
    attribute :asset,  Asset
    attribute :from,   MuxedAccount
    attribute :amount, Int64
  end
end
