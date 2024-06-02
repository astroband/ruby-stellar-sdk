# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecUDTStructV0
#   {
#       string doc<SC_SPEC_DOC_LIMIT>;
#       string lib<80>;
#       string name<60>;
#       SCSpecUDTStructFieldV0 fields<40>;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecUDTStructV0 < XDR::Struct
    attribute :doc,    XDR::String[SC_SPEC_DOC_LIMIT]
    attribute :lib,    XDR::String[80]
    attribute :name,   XDR::String[60]
    attribute :fields, XDR::VarArray[SCSpecUDTStructFieldV0, 40]
  end
end
