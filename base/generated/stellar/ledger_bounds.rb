# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerBounds
#   {
#       uint32 minLedger;
#       uint32 maxLedger; // 0 here means no maxLedger
#   };
#
# ===========================================================================
module Stellar
  class LedgerBounds < XDR::Struct
    attribute :min_ledger, Uint32
    attribute :max_ledger, Uint32
  end
end
