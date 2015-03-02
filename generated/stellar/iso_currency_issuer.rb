# Automatically generated from xdr/Stellar-types.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class ISOCurrencyIssuer < XDR::Struct

                              
    attribute :currency_code, XDR::Opaque[4]
    attribute :issuer,        AccountID
  end
end
