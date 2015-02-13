# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class HashCurrencyIssuer < XDR::Struct

                              
    attribute :currency_code, Uint256
    attribute :issuer,        AccountID
  end
end
