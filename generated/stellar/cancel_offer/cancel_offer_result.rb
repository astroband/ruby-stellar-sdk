# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module CancelOffer
    class CancelOfferResult < XDR::Struct
      autoload :Result, "#{File.dirname(__FILE__)}/cancel_offer_result/result"
                         
      attribute :result, Result
    end
  end
end
