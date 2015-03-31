# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum MessageType
#   {
#       ERROR_MSG = 0,
#       HELLO = 1,
#       DONT_HAVE = 2,
#   
#       GET_PEERS = 3, // gets a list of peers this guy knows about
#       PEERS = 4,
#   
#       GET_TX_SET = 5, // gets a particular txset by hash
#       TX_SET = 6,
#   
#       TRANSACTION = 7, // pass on a tx you have heard about
#   
#       // SCP
#       GET_SCP_QUORUMSET = 8,
#       SCP_QUORUMSET = 9,
#       SCP_MESSAGE = 10
#   };
#
# ===========================================================================
module Stellar
  class MessageType < XDR::Enum
    member :error_msg,         0
    member :hello,             1
    member :dont_have,         2
    member :get_peers,         3
    member :peers,             4
    member :get_tx_set,        5
    member :tx_set,            6
    member :transaction,       7
    member :get_scp_quorumset, 8
    member :scp_quorumset,     9
    member :scp_message,       10

    seal
  end
end
