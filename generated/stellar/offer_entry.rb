# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class OfferEntry < XDR::Struct

                           
    attribute :account_id, Uint256
    attribute :offer_id,   Uint64
    attribute :taker_gets, Currency
    attribute :taker_pays, Currency
    attribute :amount,     Int64
    attribute :price,      Price
    attribute :flags,      Int32
  end
end
