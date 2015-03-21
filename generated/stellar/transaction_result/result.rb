# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionResult
    class Result < XDR::Union
      switch_on TransactionResultCode, :code

      switch :tx_success, :results
      switch :tx_failed,  :results
      switch :default

      attribute :results, XDR::VarArray[OperationResult]
    end
  end
end
