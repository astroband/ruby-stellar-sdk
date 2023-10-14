# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct BumpFootprintExpirationOp
#   {
#       ExtensionPoint ext;
#       uint32 ledgersToExpire;
#   };
#
# ===========================================================================
module Stellar
  class BumpFootprintExpirationOp < XDR::Struct
    attribute :ext,               ExtensionPoint
    attribute :ledgers_to_expire, Uint32
  end
end
