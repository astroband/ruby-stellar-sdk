# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TTLEntry {
#       // Hash of the LedgerKey that is associated with this TTLEntry
#       Hash keyHash;
#       uint32 liveUntilLedgerSeq;
#   };
#
# ===========================================================================
module Stellar
  class TTLEntry < XDR::Struct
    attribute :key_hash,              Hash
    attribute :live_until_ledger_seq, Uint32
  end
end
