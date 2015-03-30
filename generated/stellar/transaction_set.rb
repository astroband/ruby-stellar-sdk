# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionSet < XDR::Struct
    attribute :previous_ledger_hash, Hash
    attribute :txs,                  XDR::VarArray[TransactionEnvelope, 5000]
  end
end
