# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class AllowTrustOp < XDR::Struct
    include XDR::Namespace

    autoload :Currency

    attribute :trustor,   AccountID
    attribute :currency,  Currency
    attribute :authorize, XDR::Bool
  end
end
