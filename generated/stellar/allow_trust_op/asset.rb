# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (AssetType type)
#       {
#       // ASSET_TYPE_NATIVE is not allowed
#       case ASSET_TYPE_CREDIT_ALPHANUM4:
#           opaque assetCode4[4];
#   
#   	case ASSET_TYPE_CREDIT_ALPHANUM12:
#           opaque assetCode12[12];
#   
#           // add other asset types here in the future
#       }
#
# ===========================================================================
module Stellar
  class AllowTrustOp
    class Asset < XDR::Union
      switch_on AssetType, :type

      switch :asset_type_credit_alphanum4,  :asset_code4
      switch :asset_type_credit_alphanum12, :asset_code12

      attribute :asset_code4,  XDR::Opaque[4]
      attribute :asset_code12, XDR::Opaque[12]
    end
  end
end
