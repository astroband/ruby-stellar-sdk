# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCMapEntry
#   {
#       SCVal key;
#       SCVal val;
#   };
#
# ===========================================================================
module Stellar
  class SCMapEntry < XDR::Struct
    attribute :key, SCVal
    attribute :val, SCVal
  end
end
