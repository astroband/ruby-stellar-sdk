# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionResult < XDR::Struct
    include XDR::Namespace

    autoload :Body
                            
    attribute :fee_charged, Int64
    attribute :body,        Body
  end
end
