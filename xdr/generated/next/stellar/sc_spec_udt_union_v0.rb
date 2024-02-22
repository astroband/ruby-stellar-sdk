# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecUDTUnionV0
#   {
#       string doc<SC_SPEC_DOC_LIMIT>;
#       string lib<80>;
#       string name<60>;
#       SCSpecUDTUnionCaseV0 cases<50>;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecUDTUnionV0 < XDR::Struct
    attribute :doc,   XDR::String[SC_SPEC_DOC_LIMIT]
    attribute :lib,   XDR::String[80]
    attribute :name,  XDR::String[60]
    attribute :cases, XDR::VarArray[SCSpecUDTUnionCaseV0, 50]
  end
end
