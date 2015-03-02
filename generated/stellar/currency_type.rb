# Automatically generated from xdr/Stellar-types.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class CurrencyType < XDR::Enum
    member :native,  0
    member :iso4217, 1

    seal
  end
end
