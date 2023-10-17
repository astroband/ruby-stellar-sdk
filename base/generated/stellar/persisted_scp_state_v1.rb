# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct PersistedSCPStateV1
#   {
#     // Tx sets are saved separately
#     SCPEnvelope scpEnvelopes<>;
#     SCPQuorumSet quorumSets<>;
#   };
#
# ===========================================================================
module Stellar
  class PersistedSCPStateV1 < XDR::Struct
    attribute :scp_envelopes, XDR::VarArray[SCPEnvelope]
    attribute :quorum_sets,   XDR::VarArray[SCPQuorumSet]
  end
end
