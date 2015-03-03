# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class CreateOfferTx < XDR::Struct
    attribute :taker_gets, Currency
    attribute :taker_pays, Currency
    attribute :amount,     Int64
    attribute :price,      Price
    attribute :offer_id,   Uint64
    attribute :flags,      Uint32
  end
end
