# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AssetCode4 assetCode;
#           AccountID issuer;
#       }
#
# ===========================================================================
module StellarProtocol
  class Asset
    class AlphaNum4 < XDR::Struct
      attribute :asset_code, AssetCode4
      attribute :issuer,     AccountID
    end
  end
end
