# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class LedgerHeaderHistoryEntry < XDR::Struct
    attribute :hash,   Hash
    attribute :header, LedgerHeader
  end
end
