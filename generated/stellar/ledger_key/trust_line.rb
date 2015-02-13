# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class LedgerKey
    class TrustLine < XDR::Struct

                             
      attribute :account_id, Uint256
      attribute :currency,   Currency
    end
  end
end
