# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union TransactionEnvelope switch (EnvelopeType type)
#   {
#   case ENVELOPE_TYPE_TX_V0:
#       TransactionV0Envelope v0;
#   case ENVELOPE_TYPE_TX:
#       TransactionV1Envelope v1;
#   case ENVELOPE_TYPE_TX_FEE_BUMP:
#       FeeBumpTransactionEnvelope feeBump;
#   };
#
# ===========================================================================
module Stellar
  class TransactionEnvelope < XDR::Union
    switch_on EnvelopeType, :type

    switch :envelope_type_tx_v0,       :v0
    switch :envelope_type_tx,          :v1
    switch :envelope_type_tx_fee_bump, :fee_bump

    attribute :v0,       TransactionV0Envelope
    attribute :v1,       TransactionV1Envelope
    attribute :fee_bump, FeeBumpTransactionEnvelope
  end
end
