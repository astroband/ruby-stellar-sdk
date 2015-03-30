# Automatically generated on 2015-03-30T09:46:32-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class Currency < XDR::Union
    switch_on CurrencyType, :type

    switch :native
    switch :iso4217, :iso_ci

    attribute :iso_ci, ISOCurrencyIssuer
  end
end
