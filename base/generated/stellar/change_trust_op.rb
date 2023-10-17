# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ChangeTrustOp
#   {
#       ChangeTrustAsset line;
#
#       // if limit is set to 0, deletes the trust line
#       int64 limit;
#   };
#
# ===========================================================================
module Stellar
  class ChangeTrustOp < XDR::Struct
    attribute :line,  ChangeTrustAsset
    attribute :limit, Int64
  end
end
