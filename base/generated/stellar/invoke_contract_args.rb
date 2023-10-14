# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct InvokeContractArgs {
#       SCAddress contractAddress;
#       SCSymbol functionName;
#       SCVal args<>;
#   };
#
# ===========================================================================
module Stellar
  class InvokeContractArgs < XDR::Struct
    attribute :contract_address, SCAddress
    attribute :function_name,    SCSymbol
    attribute :args,             XDR::VarArray[SCVal]
  end
end
