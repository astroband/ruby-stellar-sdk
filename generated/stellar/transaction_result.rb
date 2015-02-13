# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class TransactionResult < XDR::Struct
    autoload :Body, "#{__dir__}/transaction_result/body"
                            
    attribute :fee_charged, Int64
    attribute :body,        Body
  end
end
