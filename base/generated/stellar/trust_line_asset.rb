# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union TrustLineAsset switch (AssetType type)
#   {
#   case ASSET_TYPE_NATIVE: // Not credit
#       void;
#   
#   case ASSET_TYPE_CREDIT_ALPHANUM4:
#       AlphaNum4 alphaNum4;
#   
#   case ASSET_TYPE_CREDIT_ALPHANUM12:
#       AlphaNum12 alphaNum12;
#   
#   case ASSET_TYPE_POOL_SHARE:
#       PoolID liquidityPoolID;
#   
#       // add other asset types here in the future
#   };
#
# ===========================================================================
module Stellar
  class TrustLineAsset < XDR::Union
    switch_on AssetType, :type

    switch :asset_type_native
    switch :asset_type_credit_alphanum4,  :alpha_num4
    switch :asset_type_credit_alphanum12, :alpha_num12
    switch :asset_type_pool_share,        :liquidity_pool_id

    attribute :alpha_num4,        AlphaNum4
    attribute :alpha_num12,       AlphaNum12
    attribute :liquidity_pool_id, PoolID
  end
end
