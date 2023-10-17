# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union StellarMessage switch (MessageType type)
#   {
#   case ERROR_MSG:
#       Error error;
#   case HELLO:
#       Hello hello;
#   case AUTH:
#       Auth auth;
#   case DONT_HAVE:
#       DontHave dontHave;
#   case GET_PEERS:
#       void;
#   case PEERS:
#       PeerAddress peers<100>;
#
#   case GET_TX_SET:
#       uint256 txSetHash;
#   case TX_SET:
#       TransactionSet txSet;
#   case GENERALIZED_TX_SET:
#       GeneralizedTransactionSet generalizedTxSet;
#
#   case TRANSACTION:
#       TransactionEnvelope transaction;
#
#   case SURVEY_REQUEST:
#       SignedSurveyRequestMessage signedSurveyRequestMessage;
#
#   case SURVEY_RESPONSE:
#       SignedSurveyResponseMessage signedSurveyResponseMessage;
#
#   // SCP
#   case GET_SCP_QUORUMSET:
#       uint256 qSetHash;
#   case SCP_QUORUMSET:
#       SCPQuorumSet qSet;
#   case SCP_MESSAGE:
#       SCPEnvelope envelope;
#   case GET_SCP_STATE:
#       uint32 getSCPLedgerSeq; // ledger seq requested ; if 0, requests the latest
#   case SEND_MORE:
#       SendMore sendMoreMessage;
#   case SEND_MORE_EXTENDED:
#       SendMoreExtended sendMoreExtendedMessage;
#   // Pull mode
#   case FLOOD_ADVERT:
#        FloodAdvert floodAdvert;
#   case FLOOD_DEMAND:
#        FloodDemand floodDemand;
#   };
#
# ===========================================================================
module Stellar
  class StellarMessage < XDR::Union
    switch_on MessageType, :type

    switch :error_msg,          :error
    switch :hello,              :hello
    switch :auth,               :auth
    switch :dont_have,          :dont_have
    switch :get_peers
    switch :peers,              :peers
    switch :get_tx_set,         :tx_set_hash
    switch :tx_set,             :tx_set
    switch :generalized_tx_set, :generalized_tx_set
    switch :transaction,        :transaction
    switch :survey_request,     :signed_survey_request_message
    switch :survey_response,    :signed_survey_response_message
    switch :get_scp_quorumset,  :q_set_hash
    switch :scp_quorumset,      :q_set
    switch :scp_message,        :envelope
    switch :get_scp_state,      :get_scp_ledger_seq
    switch :send_more,          :send_more_message
    switch :send_more_extended, :send_more_extended_message
    switch :flood_advert,       :flood_advert
    switch :flood_demand,       :flood_demand

    attribute :error,                          Error
    attribute :hello,                          Hello
    attribute :auth,                           Auth
    attribute :dont_have,                      DontHave
    attribute :peers,                          XDR::VarArray[PeerAddress, 100]
    attribute :tx_set_hash,                    Uint256
    attribute :tx_set,                         TransactionSet
    attribute :generalized_tx_set,             GeneralizedTransactionSet
    attribute :transaction,                    TransactionEnvelope
    attribute :signed_survey_request_message,  SignedSurveyRequestMessage
    attribute :signed_survey_response_message, SignedSurveyResponseMessage
    attribute :q_set_hash,                     Uint256
    attribute :q_set,                          SCPQuorumSet
    attribute :envelope,                       SCPEnvelope
    attribute :get_scp_ledger_seq,             Uint32
    attribute :send_more_message,              SendMore
    attribute :send_more_extended_message,     SendMoreExtended
    attribute :flood_advert,                   FloodAdvert
    attribute :flood_demand,                   FloodDemand
  end
end
