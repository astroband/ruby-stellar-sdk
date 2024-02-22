# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SorobanAuthorizedInvocation
#   {
#       SorobanAuthorizedFunction function;
#       SorobanAuthorizedInvocation subInvocations<>;
#   };
#
# ===========================================================================
module Stellar
  class SorobanAuthorizedInvocation < XDR::Struct
    attribute :function,        SorobanAuthorizedFunction
    attribute :sub_invocations, XDR::VarArray[SorobanAuthorizedInvocation]
  end
end
