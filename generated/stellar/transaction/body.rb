# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class Transaction
    class Body < XDR::Union


      switch_on TransactionType, :type
                                            
      switch TransactionType.payment,       :payment_tx
      switch TransactionType.create_offer,  :create_offer_tx
      switch TransactionType.cancel_offer,  :offer_seq_num
      switch TransactionType.set_options,   :set_options_tx
      switch TransactionType.change_trust,  :change_trust_tx
      switch TransactionType.allow_trust,   :allow_trust_tx
      switch TransactionType.account_merge, :destination
      switch TransactionType.inflation,     :inflation_seq
                                  
      attribute :payment_tx,      PaymentTx
      attribute :create_offer_tx, CreateOfferTx
      attribute :offer_seq_num,   Uint32
      attribute :set_options_tx,  SetOptionsTx
      attribute :change_trust_tx, ChangeTrustTx
      attribute :allow_trust_tx,  AllowTrustTx
      attribute :destination,     Uint256
      attribute :inflation_seq,   Uint32
    end
  end
end
