# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (EnvelopeType type)
#       {
#       case ENVELOPE_TYPE_TX:
#           Transaction tx;
#           /* All other values of type are invalid */
#       }
#
# ===========================================================================
module Stellar
  class TransactionSignaturePayload
    class TaggedTransaction < XDR::Union
      switch_on EnvelopeType, :type

      switch :envelope_type_tx, :tx

      attribute :tx, Transaction
    end
  end
end
