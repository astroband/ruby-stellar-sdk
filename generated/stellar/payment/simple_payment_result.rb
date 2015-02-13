# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module Payment
    class SimplePaymentResult < XDR::Struct

                              
      attribute :destination, AccountID
      attribute :currency,    Currency
      attribute :amount,      Int64
    end
  end
end
