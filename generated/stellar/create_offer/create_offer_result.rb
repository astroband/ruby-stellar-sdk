# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module CreateOffer
    class CreateOfferResult < XDR::Struct
      autoload :Result, "#{__dir__}/create_offer_result/result"
                         
      attribute :result, Result
    end
  end
end
