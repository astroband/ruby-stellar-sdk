# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SorobanResources
#   {
#       // The ledger footprint of the transaction.
#       LedgerFootprint footprint;
#       // The maximum number of instructions this transaction can use
#       uint32 instructions;
#
#       // The maximum number of bytes this transaction can read from ledger
#       uint32 readBytes;
#       // The maximum number of bytes this transaction can write to ledger
#       uint32 writeBytes;
#   };
#
# ===========================================================================
module Stellar
  class SorobanResources < XDR::Struct
    attribute :footprint,    LedgerFootprint
    attribute :instructions, Uint32
    attribute :read_bytes,   Uint32
    attribute :write_bytes,  Uint32
  end
end
