# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct InvokeHostFunctionOp
#   {
#       // The host function to invoke
#       HostFunction function;
#       // The footprint for this invocation
#       LedgerFootprint footprint;
#       // Per-address authorizations for this host fn
#       // Currently only supported for INVOKE_CONTRACT function
#       ContractAuth auth<>;
#   };
#
# ===========================================================================
module Stellar
  class InvokeHostFunctionOp < XDR::Struct
    attribute :function,  HostFunction
    attribute :footprint, LedgerFootprint
    attribute :auth,      XDR::VarArray[ContractAuth]
  end
end
