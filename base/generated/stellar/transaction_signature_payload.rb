# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionSignaturePayload
#   {
#       Hash networkId;
#       union switch (EnvelopeType type)
#       {
#       case ENVELOPE_TYPE_TX:
#           Transaction tx;
#           /* All other values of type are invalid */
#       }
#       taggedTransaction;
#   };
#
# ===========================================================================
module Stellar
  class TransactionSignaturePayload < XDR::Struct
    include XDR::Namespace

    autoload :TaggedTransaction

    attribute :network_id,         Hash
    attribute :tagged_transaction, TaggedTransaction
  end
end
