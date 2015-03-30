# Automatically generated on 2015-03-30T09:46:32-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class ISOCurrencyIssuer < XDR::Struct
    attribute :currency_code, XDR::Opaque[4]
    attribute :issuer,        AccountID
  end
end
