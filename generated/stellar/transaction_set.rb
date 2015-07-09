# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionSet
#   {
#       Hash previousLedgerHash;
#       TransactionEnvelope txs<MAX_TX_PER_LEDGER>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionSet < XDR::Struct
    attribute :previous_ledger_hash, Hash
    attribute :txs,                  XDR::VarArray[TransactionEnvelope, MAX_TX_PER_LEDGER]
  end
end
