# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ChangeTrustOp
#   {
#       Asset line;
#   
#       // if limit is set to 0, deletes the trust line
#       int64 limit;
#   };
#
# ===========================================================================
module StellarProtocol
  class ChangeTrustOp < XDR::Struct
    attribute :line,  Asset
    attribute :limit, Int64
  end
end
