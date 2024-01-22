# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ExtendFootprintTTLOp
#   {
#       ExtensionPoint ext;
#       uint32 extendTo;
#   };
#
# ===========================================================================
module Stellar
  class ExtendFootprintTTLOp < XDR::Struct
    attribute :ext,       ExtensionPoint
    attribute :extend_to, Uint32
  end
end
