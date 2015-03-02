# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class AllowTrustTx < XDR::Struct
    autoload :Code, "#{File.dirname(__FILE__)}/allow_trust_tx/code"
                          
    attribute :trustor,   AccountID
    attribute :code,      Code
    attribute :authorize, XDR::Bool
  end
end
