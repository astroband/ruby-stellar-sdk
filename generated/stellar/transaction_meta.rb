# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class TransactionMetum < XDR::Struct

                        
    attribute :entries, XDR::VarArray[CLFEntry]
  end
end
