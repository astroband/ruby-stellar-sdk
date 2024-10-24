# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCMetaV0
#   {
#       string key<>;
#       string val<>;
#   };
#
# ===========================================================================
module Stellar
  class SCMetaV0 < XDR::Struct
    attribute :key, XDR::String[]
    attribute :val, XDR::String[]
  end
end
