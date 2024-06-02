# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct InvokeHostFunctionOp
#   {
#       // Host function to invoke.
#       HostFunction hostFunction;
#       // Per-address authorizations for this host function.
#       SorobanAuthorizationEntry auth<>;
#   };
#
# ===========================================================================
module Stellar
  class InvokeHostFunctionOp < XDR::Struct
    attribute :host_function, HostFunction
    attribute :auth,          XDR::VarArray[SorobanAuthorizationEntry]
  end
end
