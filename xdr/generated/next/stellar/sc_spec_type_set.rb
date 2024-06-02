# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecTypeSet
#   {
#       SCSpecTypeDef elementType;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecTypeSet < XDR::Struct
    attribute :element_type, SCSpecTypeDef
  end
end
