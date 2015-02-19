# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class LedgerKey
    class Offer < XDR::Struct

                             
      attribute :account_id, Uint256
      attribute :sequence,   Uint32
    end
  end
end
