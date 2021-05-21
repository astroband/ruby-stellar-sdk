# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SurveyResponseMessage
#   {
#       NodeID surveyorPeerID;
#       NodeID surveyedPeerID;
#       uint32 ledgerNum;
#       SurveyMessageCommandType commandType;
#       EncryptedBody encryptedBody;
#   };
#
# ===========================================================================
module StellarProtocol
  class SurveyResponseMessage < XDR::Struct
    attribute :surveyor_peer_id, NodeID
    attribute :surveyed_peer_id, NodeID
    attribute :ledger_num,       Uint32
    attribute :command_type,     SurveyMessageCommandType
    attribute :encrypted_body,   EncryptedBody
  end
end
