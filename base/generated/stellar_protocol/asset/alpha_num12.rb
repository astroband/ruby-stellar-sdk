# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AssetCode12 assetCode;
#           AccountID issuer;
#       }
#
# ===========================================================================
module StellarProtocol
  class Asset
    class AlphaNum12 < XDR::Struct
      attribute :asset_code, AssetCode12
      attribute :issuer,     AccountID
    end
  end
end
