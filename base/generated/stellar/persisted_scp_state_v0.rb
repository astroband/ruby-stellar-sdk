# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct PersistedSCPStateV0
#   {
#   	SCPEnvelope scpEnvelopes<>;
#   	SCPQuorumSet quorumSets<>;
#   	StoredTransactionSet txSets<>;
#   };
#
# ===========================================================================
module Stellar
  class PersistedSCPStateV0 < XDR::Struct
    attribute :scp_envelopes, XDR::VarArray[SCPEnvelope]
    attribute :quorum_sets,   XDR::VarArray[SCPQuorumSet]
    attribute :tx_sets,       XDR::VarArray[StoredTransactionSet]
  end
end
