# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class AllowTrustOp
    class Currency < XDR::Union
      switch_on CurrencyType, :type

      switch :iso4217, :currency_code

      attribute :currency_code, XDR::Opaque[4]
    end
  end
end
