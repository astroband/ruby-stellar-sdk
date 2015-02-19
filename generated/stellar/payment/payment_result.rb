# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module Payment
    class PaymentResult < XDR::Struct
      autoload :Result, "#{File.dirname(__FILE__)}/payment_result/result"
                         
      attribute :result, Result
    end
  end
end
