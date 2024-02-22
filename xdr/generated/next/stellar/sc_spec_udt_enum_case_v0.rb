# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecUDTEnumCaseV0
#   {
#       string doc<SC_SPEC_DOC_LIMIT>;
#       string name<60>;
#       uint32 value;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecUDTEnumCaseV0 < XDR::Struct
    attribute :doc,   XDR::String[SC_SPEC_DOC_LIMIT]
    attribute :name,  XDR::String[60]
    attribute :value, Uint32
  end
end
