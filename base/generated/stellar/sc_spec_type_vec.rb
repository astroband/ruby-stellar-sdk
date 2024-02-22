# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecTypeVec
#   {
#       SCSpecTypeDef elementType;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecTypeVec < XDR::Struct
    attribute :element_type, SCSpecTypeDef
  end
end
