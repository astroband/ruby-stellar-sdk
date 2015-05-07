# Automatically generated on 2015-05-07T07:56:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionSet
#   {
#       Hash previousLedgerHash;
#       TransactionEnvelope txs<5000>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionSet < XDR::Struct
    attribute :previous_ledger_hash, Hash
    attribute :txs,                  XDR::VarArray[TransactionEnvelope, 5000]
  end
end
