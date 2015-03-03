# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionResult
    class Body
      class Tr < XDR::Union
        switch_on TransactionType, :type
                               
        switch :payment,       :payment_result
        switch :create_offer,  :create_offer_result
        switch :cancel_offer,  :cancel_offer_result
        switch :set_options,   :set_options_result
        switch :change_trust,  :change_trust_result
        switch :allow_trust,   :allow_trust_result
        switch :account_merge, :account_merge_result
        switch :set_seq_slot,  :set_seq_slot_result
        switch :inflation,     :inflation_result
                                         
        attribute :payment_result,       Payment::PaymentResult
        attribute :create_offer_result,  CreateOffer::CreateOfferResult
        attribute :cancel_offer_result,  CancelOffer::CancelOfferResult
        attribute :set_options_result,   SetOptions::SetOptionsResult
        attribute :change_trust_result,  ChangeTrust::ChangeTrustResult
        attribute :allow_trust_result,   AllowTrust::AllowTrustResult
        attribute :account_merge_result, AccountMerge::AccountMergeResult
        attribute :set_seq_slot_result,  SetSeqSlot::SetSeqSlotResult
        attribute :inflation_result,     Inflation::InflationResult
      end
    end
  end
end
