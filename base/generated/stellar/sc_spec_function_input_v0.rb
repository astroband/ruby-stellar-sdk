# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecFunctionInputV0
#   {
#       string doc<SC_SPEC_DOC_LIMIT>;
#       string name<30>;
#       SCSpecTypeDef type;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecFunctionInputV0 < XDR::Struct
    attribute :doc,  XDR::String[SC_SPEC_DOC_LIMIT]
    attribute :name, XDR::String[30]
    attribute :type, SCSpecTypeDef
  end
end
