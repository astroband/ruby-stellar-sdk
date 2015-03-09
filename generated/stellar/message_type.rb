# Automatically generated from xdr/Stellar-overlay.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class MessageType < XDR::Enum
    member :error_msg,         0
    member :hello,             1
    member :dont_have,         2
    member :get_peers,         3
    member :peers,             4
    member :get_tx_set,        5
    member :tx_set,            6
    member :get_validations,   7
    member :validations,       8
    member :transaction,       9
    member :json_transaction,  10
    member :get_scp_quorumset, 11
    member :scp_quorumset,     12
    member :scp_message,       13

    seal
  end
end
