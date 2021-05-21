# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union AssetCode switch (AssetType type)
#   {
#   case ASSET_TYPE_CREDIT_ALPHANUM4:
#       AssetCode4 assetCode4;
#   
#   case ASSET_TYPE_CREDIT_ALPHANUM12:
#       AssetCode12 assetCode12;
#   
#       // add other asset types here in the future
#   };
#
# ===========================================================================
module StellarProtocol
  class AssetCode < XDR::Union
    switch_on AssetType, :type

    switch :asset_type_credit_alphanum4,  :asset_code4
    switch :asset_type_credit_alphanum12, :asset_code12

    attribute :asset_code4,  AssetCode4
    attribute :asset_code12, AssetCode12
  end
end
