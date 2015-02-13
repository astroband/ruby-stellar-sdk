# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module Payment
    class ClaimOfferAtom < XDR::Struct

                                 
      attribute :offer_owner,    AccountID
      attribute :offer_sequence, Uint32
      attribute :currency_sent,  Currency
      attribute :amount_sent,    Int64
    end
  end
end
