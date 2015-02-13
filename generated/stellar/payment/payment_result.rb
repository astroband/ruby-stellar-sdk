# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module Payment
    class PaymentResult < XDR::Struct
      autoload :Result, "#{__dir__}/payment_result/result"
                         
      attribute :result, Result
    end
  end
end
