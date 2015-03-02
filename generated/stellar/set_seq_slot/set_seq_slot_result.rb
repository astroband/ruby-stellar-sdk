# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module SetSeqSlot
    class SetSeqSlotResult < XDR::Union


      switch_on SetSeqSlotResultCode, :code

      switch :success
      switch :default

    end
  end
end
