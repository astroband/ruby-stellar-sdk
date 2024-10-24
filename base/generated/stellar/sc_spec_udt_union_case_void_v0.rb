# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecUDTUnionCaseVoidV0
#   {
#       string doc<SC_SPEC_DOC_LIMIT>;
#       string name<60>;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecUDTUnionCaseVoidV0 < XDR::Struct
    attribute :doc,  XDR::String[SC_SPEC_DOC_LIMIT]
    attribute :name, XDR::String[60]
  end
end
