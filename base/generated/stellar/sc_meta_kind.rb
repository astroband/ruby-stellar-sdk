# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCMetaKind
#   {
#       SC_META_V0 = 0
#   };
#
# ===========================================================================
module Stellar
  class SCMetaKind < XDR::Enum
    member :sc_meta_v0, 0

    seal
  end
end
