# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecUDTUnionCaseTupleV0
#   {
#       string doc<SC_SPEC_DOC_LIMIT>;
#       string name<60>;
#       SCSpecTypeDef type<12>;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecUDTUnionCaseTupleV0 < XDR::Struct
    attribute :doc,  XDR::String[SC_SPEC_DOC_LIMIT]
    attribute :name, XDR::String[60]
    attribute :type, XDR::VarArray[SCSpecTypeDef, 12]
  end
end
