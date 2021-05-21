# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionSet
#   {
#       Hash previousLedgerHash;
#       TransactionEnvelope txs<>;
#   };
#
# ===========================================================================
module StellarProtocol
  class TransactionSet < XDR::Struct
    attribute :previous_ledger_hash, Hash
    attribute :txs,                  XDR::VarArray[TransactionEnvelope]
  end
end
