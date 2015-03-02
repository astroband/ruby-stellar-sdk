# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class ClaimOfferAtom < XDR::Struct

                                 
    attribute :offer_owner,      AccountID
    attribute :offer_id,         Uint64
    attribute :currency_claimed, Currency
    attribute :amount_claimed,   Int64
  end
end
