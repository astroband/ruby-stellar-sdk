# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionEnvelope < XDR::Struct
    attribute :tx,         Transaction
    attribute :signatures, XDR::VarArray[Uint512]
  end
end
