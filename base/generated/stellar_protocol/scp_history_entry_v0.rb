# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCPHistoryEntryV0
#   {
#       SCPQuorumSet quorumSets<>; // additional quorum sets used by ledgerMessages
#       LedgerSCPMessages ledgerMessages;
#   };
#
# ===========================================================================
module StellarProtocol
  class SCPHistoryEntryV0 < XDR::Struct
    attribute :quorum_sets,     XDR::VarArray[SCPQuorumSet]
    attribute :ledger_messages, LedgerSCPMessages
  end
end
