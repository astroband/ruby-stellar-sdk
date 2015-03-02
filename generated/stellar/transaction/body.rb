# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class Transaction
    class Body < XDR::Union


      switch_on TransactionType, :type
                             
      switch :payment,       :payment_tx
      switch :create_offer,  :create_offer_tx
      switch :cancel_offer,  :offer_id
      switch :set_options,   :set_options_tx
      switch :change_trust,  :change_trust_tx
      switch :allow_trust,   :allow_trust_tx
      switch :account_merge, :destination
      switch :set_seq_slot,  :set_seq_slot_tx
      switch :inflation,     :inflation_seq
                                  
      attribute :payment_tx,      PaymentTx
      attribute :create_offer_tx, CreateOfferTx
      attribute :offer_id,        Uint64
      attribute :set_options_tx,  SetOptionsTx
      attribute :change_trust_tx, ChangeTrustTx
      attribute :allow_trust_tx,  AllowTrustTx
      attribute :destination,     Uint256
      attribute :set_seq_slot_tx, SetSeqSlotTx
      attribute :inflation_seq,   Uint32
    end
  end
end
