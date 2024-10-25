# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionSetV1
#   {
#       Hash previousLedgerHash;
#       TransactionPhase phases<>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionSetV1 < XDR::Struct
    attribute :previous_ledger_hash, Hash
    attribute :phases,               XDR::VarArray[TransactionPhase]
  end
end
