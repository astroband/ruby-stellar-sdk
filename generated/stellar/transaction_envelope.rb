# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionEnvelope < XDR::Struct
    attribute :tx,         Transaction
    attribute :signatures, XDR::VarArray[DecoratedSignature, 20]
  end
end
