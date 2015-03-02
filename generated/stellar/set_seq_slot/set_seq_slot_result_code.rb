# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module SetSeqSlot
    class SetSeqSlotResultCode < XDR::Enum
      member :success,         0
      member :malformed,       1
      member :invalid_slot,    2
      member :invalid_seq_num, 3

      seal
    end
  end
end
