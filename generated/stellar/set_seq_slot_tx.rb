# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class SetSeqSlotTx < XDR::Struct
    attribute :slot_index, Uint32
    attribute :slot_value, Uint32
  end
end
