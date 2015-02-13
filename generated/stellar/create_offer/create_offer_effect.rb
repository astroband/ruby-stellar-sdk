# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

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
