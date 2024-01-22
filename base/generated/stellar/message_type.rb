# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum MessageType
#   {
#       ERROR_MSG = 0,
#       AUTH = 2,
#       DONT_HAVE = 3,
#   
#       GET_PEERS = 4, // gets a list of peers this guy knows about
#       PEERS = 5,
#   
#       GET_TX_SET = 6, // gets a particular txset by hash
#       TX_SET = 7,
#       GENERALIZED_TX_SET = 17,
#   
#       TRANSACTION = 8, // pass on a tx you have heard about
#   
#       // SCP
#       GET_SCP_QUORUMSET = 9,
#       SCP_QUORUMSET = 10,
#       SCP_MESSAGE = 11,
#       GET_SCP_STATE = 12,
#   
#       // new messages
#       HELLO = 13,
#   
#       SURVEY_REQUEST = 14,
#       SURVEY_RESPONSE = 15,
#   
#       SEND_MORE = 16,
#       SEND_MORE_EXTENDED = 20,
#   
#       FLOOD_ADVERT = 18,
#       FLOOD_DEMAND = 19
#   };
#
# ===========================================================================
module Stellar
  class MessageType < XDR::Enum
    member :error_msg,          0
    member :auth,               2
    member :dont_have,          3
    member :get_peers,          4
    member :peers,              5
    member :get_tx_set,         6
    member :tx_set,             7
    member :generalized_tx_set, 17
    member :transaction,        8
    member :get_scp_quorumset,  9
    member :scp_quorumset,      10
    member :scp_message,        11
    member :get_scp_state,      12
    member :hello,              13
    member :survey_request,     14
    member :survey_response,    15
    member :send_more,          16
    member :send_more_extended, 20
    member :flood_advert,       18
    member :flood_demand,       19

    seal
  end
end
