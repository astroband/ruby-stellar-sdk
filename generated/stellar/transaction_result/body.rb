# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class TransactionResult
    class Body < XDR::Union
      autoload :Tr, "#{__dir__}/body/tr"

      switch_on TransactionResultCode, :code
                                             
      switch TransactionResultCode.tx_inner, :tr
                                                   switch :default
                     
      attribute :tr, Tr
    end
  end
end
