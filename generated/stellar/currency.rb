# Automatically generated from xdr/Stellar-types.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class Currency < XDR::Union


    switch_on CurrencyType, :type
                                 
                                     switch CurrencyType.native
    switch CurrencyType.iso4217, :iso_ci
                       
    attribute :iso_ci, ISOCurrencyIssuer
  end
end
