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
#       // Backwards Compatibility: Use ENVELOPE_TYPE_TX to sign ENVELOPE_TYPE_TX_V0
#       case ENVELOPE_TYPE_TX:
#           Transaction tx;
#       case ENVELOPE_TYPE_TX_FEE_BUMP:
#           FeeBumpTransaction feeBump;
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
