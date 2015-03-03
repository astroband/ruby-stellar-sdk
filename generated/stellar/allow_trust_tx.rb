# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class AllowTrustTx < XDR::Struct
    include XDR::Namespace

    autoload :Code
                          
    attribute :trustor,   AccountID
    attribute :code,      Code
    attribute :authorize, XDR::Bool
  end
end
