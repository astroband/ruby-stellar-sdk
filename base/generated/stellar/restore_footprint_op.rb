# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct RestoreFootprintOp
#   {
#       ExtensionPoint ext;
#   };
#
# ===========================================================================
module Stellar
  class RestoreFootprintOp < XDR::Struct
    attribute :ext, ExtensionPoint
  end
end
