# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class TransactionResult
    class Body < XDR::Union
      autoload :Tr, "#{File.dirname(__FILE__)}/body/tr"

      switch_on TransactionResultCode, :code
                                             
      switch TransactionResultCode.tx_inner, :tr
                                                   switch :default
                     
      attribute :tr, Tr
    end
  end
end
