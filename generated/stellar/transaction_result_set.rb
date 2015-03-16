# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionResultSet < XDR::Struct
    attribute :results, XDR::VarArray[TransactionResultPair, 5000]
  end
end
