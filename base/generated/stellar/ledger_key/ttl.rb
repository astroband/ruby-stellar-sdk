# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           // Hash of the LedgerKey that is associated with this TTLEntry
#           Hash keyHash;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class Ttl < XDR::Struct
      attribute :key_hash, Hash
    end
  end
end
