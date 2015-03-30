# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionResult < XDR::Struct
    include XDR::Namespace

    autoload :Result

    attribute :fee_charged, Int64
    attribute :result,      Result
  end
end
