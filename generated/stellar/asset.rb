# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union Asset switch (AssetType type)
#   {
#   case ASSET_TYPE_NATIVE: // Not credit
#       void;
#   
#   case ASSET_TYPE_CREDIT_ALPHANUM4:
#       struct
#       {
#           opaque assetCode[4];
#           AccountID issuer;
#       } alphaNum4;
#   
#   case ASSET_TYPE_CREDIT_ALPHANUM12:
#       struct
#       {
#           opaque assetCode[12];
#           AccountID issuer;
#       } alphaNum12;
#   
#       // add other asset types here in the future
#   };
#
# ===========================================================================
module Stellar
  class Asset < XDR::Union
    include XDR::Namespace

    autoload :AlphaNum4
    autoload :AlphaNum12

    switch_on AssetType, :type

    switch :asset_type_native
    switch :asset_type_credit_alphanum4,  :alpha_num4
    switch :asset_type_credit_alphanum12, :alpha_num12

    attribute :alpha_num4,  AlphaNum4
    attribute :alpha_num12, AlphaNum12
  end
end
