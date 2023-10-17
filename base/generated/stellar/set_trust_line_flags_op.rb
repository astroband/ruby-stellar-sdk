# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SetTrustLineFlagsOp
#   {
#       AccountID trustor;
#       Asset asset;
#
#       uint32 clearFlags; // which flags to clear
#       uint32 setFlags;   // which flags to set
#   };
#
# ===========================================================================
module Stellar
  class SetTrustLineFlagsOp < XDR::Struct
    attribute :trustor,     AccountID
    attribute :asset,       Asset
    attribute :clear_flags, Uint32
    attribute :set_flags,   Uint32
  end
end
