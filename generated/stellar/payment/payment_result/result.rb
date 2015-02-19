# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module Payment
    class PaymentResult
      class Result < XDR::Union


        switch_on PaymentResultCode, :code
                                                
                                                        switch PaymentResultCode.success
        switch PaymentResultCode.success_multi, :multi
                                                        switch :default
                          
        attribute :multi, SuccessMultiResult
      end
    end
  end
end
