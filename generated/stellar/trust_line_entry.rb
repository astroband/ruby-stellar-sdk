# Automatically generated on 2015-03-30T09:46:31-07:00
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
