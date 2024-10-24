# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct StoredDebugTransactionSet
#   {
#   	StoredTransactionSet txSet;
#   	uint32 ledgerSeq;
#   	StellarValue scpValue;
#   };
#
# ===========================================================================
module Stellar
  class StoredDebugTransactionSet < XDR::Struct
    attribute :tx_set,     StoredTransactionSet
    attribute :ledger_seq, Uint32
    attribute :scp_value,  StellarValue
  end
end
