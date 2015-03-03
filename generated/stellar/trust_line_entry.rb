# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TrustLineEntry < XDR::Struct
    attribute :account_id, Uint256
    attribute :currency,   Currency
    attribute :limit,      Int64
    attribute :balance,    Int64
    attribute :authorized, XDR::Bool
  end
end
