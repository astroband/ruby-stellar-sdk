# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecFunctionV0
#   {
#       string doc<SC_SPEC_DOC_LIMIT>;
#       SCSymbol name;
#       SCSpecFunctionInputV0 inputs<10>;
#       SCSpecTypeDef outputs<1>;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecFunctionV0 < XDR::Struct
    attribute :doc,     XDR::String[SC_SPEC_DOC_LIMIT]
    attribute :name,    SCSymbol
    attribute :inputs,  XDR::VarArray[SCSpecFunctionInputV0, 10]
    attribute :outputs, XDR::VarArray[SCSpecTypeDef, 1]
  end
end
