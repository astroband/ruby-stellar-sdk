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
#           AssetCode4 assetCode4;
#   
#       case ASSET_TYPE_CREDIT_ALPHANUM12:
#           AssetCode12 assetCode12;
#   
#           // add other asset types here in the future
#       }
#       asset;
#   
#       // 0, or any bitwise combination of TrustLineFlags
#       uint32 authorize;
#   };
#
# ===========================================================================
module Stellar
  class AllowTrustOp < XDR::Struct
    include XDR::Namespace

    autoload :Asset

    attribute :trustor,   AccountID
    attribute :asset,     Asset
    attribute :authorize, Uint32
  end
end
