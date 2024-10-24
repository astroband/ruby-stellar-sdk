# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SorobanAuthorizationEntry
#   {
#       SorobanCredentials credentials;
#       SorobanAuthorizedInvocation rootInvocation;
#   };
#
# ===========================================================================
module Stellar
  class SorobanAuthorizationEntry < XDR::Struct
    attribute :credentials,     SorobanCredentials
    attribute :root_invocation, SorobanAuthorizedInvocation
  end
end
