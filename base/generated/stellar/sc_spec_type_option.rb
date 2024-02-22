# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecTypeOption
#   {
#       SCSpecTypeDef valueType;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecTypeOption < XDR::Struct
    attribute :value_type, SCSpecTypeDef
  end
end
