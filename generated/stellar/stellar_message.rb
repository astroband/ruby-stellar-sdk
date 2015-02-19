# Automatically generated from xdr/Stellar-overlay.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class StellarMessage < XDR::Union


    switch_on MessageType, :type
                                          
    switch MessageType.error_msg,         :error
    switch MessageType.hello,             :hello
    switch MessageType.dont_have,         :dont_have
                                              switch MessageType.get_peers
    switch MessageType.peers,             :peers
    switch MessageType.get_tx_set,        :tx_set_hash
    switch MessageType.tx_set,            :tx_set
    switch MessageType.get_validations,   :ledger_hash
    switch MessageType.validations,       :validations
    switch MessageType.transaction,       :transaction
    switch MessageType.get_fba_quorumset, :q_set_hash
    switch MessageType.fba_quorumset,     :q_set
    switch MessageType.fba_message,       :envelope
                            
    attribute :error,       Error
    attribute :hello,       Hello
    attribute :dont_have,   DontHave
    attribute :peers,       XDR::VarArray[PeerAddress]
    attribute :tx_set_hash, Uint256
    attribute :tx_set,      TransactionSet
    attribute :ledger_hash, Uint256
    attribute :validations, XDR::VarArray[FBAEnvelope]
    attribute :transaction, TransactionEnvelope
    attribute :q_set_hash,  Uint256
    attribute :q_set,       FBAQuorumSet
    attribute :envelope,    FBAEnvelope
  end
end
