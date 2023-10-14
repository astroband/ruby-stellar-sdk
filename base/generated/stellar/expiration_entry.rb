# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ExpirationEntry {
#       // Hash of the LedgerKey that is associated with this ExpirationEntry
#       Hash keyHash;
#       uint32 expirationLedgerSeq;
#   };
#
# ===========================================================================
module Stellar
  class ExpirationEntry < XDR::Struct
    attribute :key_hash,              Hash
    attribute :expiration_ledger_seq, Uint32
  end
end
