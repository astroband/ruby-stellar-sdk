# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class AllowTrustTx < XDR::Struct
    autoload :Code, "#{__dir__}/allow_trust_tx/code"
                          
    attribute :trustor,   AccountID
    attribute :code,      Code
    attribute :authorize, XDR::Bool
  end
end
