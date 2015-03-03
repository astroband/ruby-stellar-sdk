# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionMeta < XDR::Struct
    attribute :entries, XDR::VarArray[CLFEntry]
  end
end
