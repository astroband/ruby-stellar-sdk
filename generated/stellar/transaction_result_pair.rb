# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionResultPair < XDR::Struct
    attribute :transaction_hash, Hash
    attribute :result,           TransactionResult
  end
end
