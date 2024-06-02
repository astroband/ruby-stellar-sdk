# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct InvokeHostFunctionSuccessPreImage
#   {
#       SCVal returnValue;
#       ContractEvent events<>;
#   };
#
# ===========================================================================
module Stellar
  class InvokeHostFunctionSuccessPreImage < XDR::Struct
    attribute :return_value, SCVal
    attribute :events,       XDR::VarArray[ContractEvent]
  end
end
