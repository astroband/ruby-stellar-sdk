# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct CreateClaimableBalanceOp
#   {
#       Asset asset;
#       int64 amount;
#       Claimant claimants<10>;
#   };
#
# ===========================================================================
module Stellar
  class CreateClaimableBalanceOp < XDR::Struct
    attribute :asset,     Asset
    attribute :amount,    Int64
    attribute :claimants, XDR::VarArray[Claimant, 10]
  end
end
