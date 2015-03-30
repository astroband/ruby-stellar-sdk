# Automatically generated on 2015-03-30T09:46:32-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module CreateOffer
    class CreateOfferEffect < XDR::Enum
      member :created, 0
      member :updated, 1
      member :empty,   2

      seal
    end
  end
end
