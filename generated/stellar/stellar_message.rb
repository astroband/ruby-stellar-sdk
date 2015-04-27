# Automatically generated on 2015-04-26T19:13:29-07:00
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
#   case DONT_HAVE:
#       DontHave dontHave;
#   case GET_PEERS:
#       void;
#   case PEERS:
#       PeerAddress peers<>;
#   
#   case GET_TX_SET:
#       uint256 txSetHash;
#   case TX_SET:
#       TransactionSet txSet;
#   
#   case TRANSACTION:
#       TransactionEnvelope transaction;
#   
#   // SCP
#   case GET_SCP_QUORUMSET:
#       uint256 qSetHash;
#   case SCP_QUORUMSET:
#       SCPQuorumSet qSet;
#   case SCP_MESSAGE:
#       SCPEnvelope envelope;
#   };
#
# ===========================================================================
module Stellar
  class StellarMessage < XDR::Union
    switch_on MessageType, :type

    switch :error_msg,         :error
    switch :hello,             :hello
    switch :dont_have,         :dont_have
    switch :get_peers
    switch :peers,             :peers
    switch :get_tx_set,        :tx_set_hash
    switch :tx_set,            :tx_set
    switch :transaction,       :transaction
    switch :get_scp_quorumset, :q_set_hash
    switch :scp_quorumset,     :q_set
    switch :scp_message,       :envelope

    attribute :error,       Error
    attribute :hello,       Hello
    attribute :dont_have,   DontHave
    attribute :peers,       XDR::VarArray[PeerAddress]
    attribute :tx_set_hash, Uint256
    attribute :tx_set,      TransactionSet
    attribute :transaction, TransactionEnvelope
    attribute :q_set_hash,  Uint256
    attribute :q_set,       SCPQuorumSet
    attribute :envelope,    SCPEnvelope
  end
end
