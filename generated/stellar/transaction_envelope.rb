# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionEnvelope
#   {
#       Transaction tx;
#       /* Each decorated signature is a signature over the SHA256 hash of
#        * a TransactionSignaturePayload */
#       DecoratedSignature signatures<20>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionEnvelope < XDR::Struct
    attribute :tx,         Transaction
    attribute :signatures, XDR::VarArray[DecoratedSignature, 20]
  end
end
