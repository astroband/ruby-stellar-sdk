# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           opaque assetCode[12];
#           AccountID issuer;
#       }
#
# ===========================================================================
module Stellar
  class Asset
    class AlphaNum12 < XDR::Struct
      attribute :asset_code, XDR::Opaque[12]
      attribute :issuer,     AccountID
    end
  end
end
