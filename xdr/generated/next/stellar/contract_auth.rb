# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ContractAuth
#   {
#       AddressWithNonce* addressWithNonce; // not present for invoker
#       AuthorizedInvocation rootInvocation;
#       SCVec signatureArgs;
#   };
#
# ===========================================================================
module Stellar
  class ContractAuth < XDR::Struct
    attribute :address_with_nonce, XDR::Option[AddressWithNonce]
    attribute :root_invocation,    AuthorizedInvocation
    attribute :signature_args,     SCVec
  end
end
