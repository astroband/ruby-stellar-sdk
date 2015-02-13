# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class TransactionResult
    class Body
      class Tr < XDR::Union


        switch_on TransactionType, :type
                                              
        switch TransactionType.payment,       :payment_result
        switch TransactionType.create_offer,  :create_offer_result
        switch TransactionType.cancel_offer,  :cancel_offer_result
        switch TransactionType.set_options,   :set_options_result
        switch TransactionType.change_trust,  :change_trust_result
        switch TransactionType.allow_trust,   :allow_trust_result
        switch TransactionType.account_merge, :account_merge_result
        switch TransactionType.inflation,     :inflation_result
                                         
        attribute :payment_result,       Payment::PaymentResult
        attribute :create_offer_result,  CreateOffer::CreateOfferResult
        attribute :cancel_offer_result,  CancelOffer::CancelOfferResult
        attribute :set_options_result,   SetOptions::SetOptionsResult
        attribute :change_trust_result,  ChangeTrust::ChangeTrustResult
        attribute :allow_trust_result,   AllowTrust::AllowTrustResult
        attribute :account_merge_result, AccountMerge::AccountMergeResult
        attribute :inflation_result,     Inflation::InflationResult
      end
    end
  end
end
