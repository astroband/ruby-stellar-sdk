# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerSCPMessages
#   {
#       uint32 ledgerSeq;
#       SCPEnvelope messages<>;
#   };
#
# ===========================================================================
module StellarProtocol
  class LedgerSCPMessages < XDR::Struct
    attribute :ledger_seq, Uint32
    attribute :messages,   XDR::VarArray[SCPEnvelope]
  end
end
