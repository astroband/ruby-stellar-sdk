# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecTypeMap
#   {
#       SCSpecTypeDef keyType;
#       SCSpecTypeDef valueType;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecTypeMap < XDR::Struct
    attribute :key_type,   SCSpecTypeDef
    attribute :value_type, SCSpecTypeDef
  end
end
