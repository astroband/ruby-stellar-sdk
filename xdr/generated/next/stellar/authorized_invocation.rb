# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct AuthorizedInvocation
#   {
#       Hash contractID;
#       SCSymbol functionName;
#       SCVec args;
#       AuthorizedInvocation subInvocations<>;
#   };
#
# ===========================================================================
module Stellar
  class AuthorizedInvocation < XDR::Struct
    attribute :contract_id,     Hash
    attribute :function_name,   SCSymbol
    attribute :args,            SCVec
    attribute :sub_invocations, XDR::VarArray[AuthorizedInvocation]
  end
end
