# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum MessageType
#   {
#       ERROR_MSG = 0,
#       HELLO = 1,
#       AUTH = 2,
#       DONT_HAVE = 3,
#   
#       GET_PEERS = 4, // gets a list of peers this guy knows about
#       PEERS = 5,
#   
#       GET_TX_SET = 6, // gets a particular txset by hash
#       TX_SET = 7,
#   
#       TRANSACTION = 8, // pass on a tx you have heard about
#   
#       // SCP
#       GET_SCP_QUORUMSET = 9,
#       SCP_QUORUMSET = 10,
#       SCP_MESSAGE = 11
#   };
#
# ===========================================================================
module Stellar
  class MessageType < XDR::Enum
    member :error_msg,         0
    member :hello,             1
    member :auth,              2
    member :dont_have,         3
    member :get_peers,         4
    member :peers,             5
    member :get_tx_set,        6
    member :tx_set,            7
    member :transaction,       8
    member :get_scp_quorumset, 9
    member :scp_quorumset,     10
    member :scp_message,       11

    seal
  end
end
