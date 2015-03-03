# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionSet < XDR::Struct
    attribute :previous_ledger_hash, Hash
    attribute :txs,                  XDR::VarArray[TransactionEnvelope]
  end
end
