# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (EnvelopeType type)
#       {
#       case ENVELOPE_TYPE_TX:
#           TransactionV1Envelope v1;
#       }
#
# ===========================================================================
module Stellar
  class FeeBumpTransaction
    class InnerTx < XDR::Union
      switch_on EnvelopeType, :type

      switch :envelope_type_tx, :v1

      attribute :v1, TransactionV1Envelope
    end
  end
end
