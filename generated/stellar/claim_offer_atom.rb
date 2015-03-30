# Automatically generated on 2015-03-30T09:46:31-07:00
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
