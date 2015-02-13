# Automatically generated from xdr/Stellar-overlay.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  autoload :StellarBallot, "#{__dir__}/stellar/stellar_ballot"
  autoload :Error, "#{__dir__}/stellar/error"
  autoload :Hello, "#{__dir__}/stellar/hello"
  autoload :PeerAddress, "#{__dir__}/stellar/peer_address"

  autoload :MessageType, "#{__dir__}/stellar/message_type"

  autoload :DontHave, "#{__dir__}/stellar/dont_have"

  autoload :StellarMessage, "#{__dir__}/stellar/stellar_message"
end
