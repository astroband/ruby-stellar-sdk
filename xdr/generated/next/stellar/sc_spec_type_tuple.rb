# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecTypeTuple
#   {
#       SCSpecTypeDef valueTypes<12>;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecTypeTuple < XDR::Struct
    attribute :value_types, XDR::VarArray[SCSpecTypeDef, 12]
  end
end
