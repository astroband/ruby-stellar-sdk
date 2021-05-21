# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SurveyRequestMessage
#   {
#       NodeID surveyorPeerID;
#       NodeID surveyedPeerID;
#       uint32 ledgerNum;
#       Curve25519Public encryptionKey;
#       SurveyMessageCommandType commandType;
#   };
#
# ===========================================================================
module StellarProtocol
  class SurveyRequestMessage < XDR::Struct
    attribute :surveyor_peer_id, NodeID
    attribute :surveyed_peer_id, NodeID
    attribute :ledger_num,       Uint32
    attribute :encryption_key,   Curve25519Public
    attribute :command_type,     SurveyMessageCommandType
  end
end
