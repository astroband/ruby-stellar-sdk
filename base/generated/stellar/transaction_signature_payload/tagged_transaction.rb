# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (EnvelopeType type)
#       {
#       // Backwards Compatibility: Use ENVELOPE_TYPE_TX to sign ENVELOPE_TYPE_TX_V0
#       case ENVELOPE_TYPE_TX:
#           Transaction tx;
#       case ENVELOPE_TYPE_TX_FEE_BUMP:
#           FeeBumpTransaction feeBump;
#       }
#
# ===========================================================================
module Stellar
  class TransactionSignaturePayload
    class TaggedTransaction < XDR::Union
      switch_on EnvelopeType, :type

      switch :envelope_type_tx,          :tx
      switch :envelope_type_tx_fee_bump, :fee_bump

      attribute :tx,       Transaction
      attribute :fee_bump, FeeBumpTransaction
    end
  end
end
