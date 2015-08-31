# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct AllowTrustOp
#   {
#       AccountID trustor;
#       union switch (AssetType type)
#       {
#       // ASSET_TYPE_NATIVE is not allowed
#       case ASSET_TYPE_CREDIT_ALPHANUM4:
#           opaque assetCode4[4];
#   
#       case ASSET_TYPE_CREDIT_ALPHANUM12:
#           opaque assetCode12[12];
#   
#           // add other asset types here in the future
#       }
#       asset;
#   
#       bool authorize;
#   };
#
# ===========================================================================
module Stellar
  class AllowTrustOp < XDR::Struct
    include XDR::Namespace

    autoload :Asset

    attribute :trustor,   AccountID
    attribute :asset,     Asset
    attribute :authorize, XDR::Bool
  end
end
