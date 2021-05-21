# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct AllowTrustOp
#   {
#       AccountID trustor;
#       AssetCode asset;
#   
#       // One of 0, AUTHORIZED_FLAG, or AUTHORIZED_TO_MAINTAIN_LIABILITIES_FLAG
#       uint32 authorize;
#   };
#
# ===========================================================================
module StellarProtocol
  class AllowTrustOp < XDR::Struct
    attribute :trustor,   AccountID
    attribute :asset,     AssetCode
    attribute :authorize, Uint32
  end
end
