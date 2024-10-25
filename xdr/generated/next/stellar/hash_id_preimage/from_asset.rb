# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash networkID;
#           Asset asset;
#       }
#
# ===========================================================================
module Stellar
  class HashIDPreimage
    class FromAsset < XDR::Struct
      attribute :network_id, Hash
      attribute :asset,      Asset
    end
  end
end
