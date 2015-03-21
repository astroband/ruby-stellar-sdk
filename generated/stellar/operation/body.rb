# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class Operation
    class Body < XDR::Union
      switch_on OperationType, :type

      switch :payment,       :payment_op
      switch :create_offer,  :create_offer_op
      switch :cancel_offer,  :offer_id
      switch :set_options,   :set_options_op
      switch :change_trust,  :change_trust_op
      switch :allow_trust,   :allow_trust_op
      switch :account_merge, :destination
      switch :inflation,     :inflation_seq

      attribute :payment_op,      PaymentOp
      attribute :create_offer_op, CreateOfferOp
      attribute :offer_id,        Uint64
      attribute :set_options_op,  SetOptionsOp
      attribute :change_trust_op, ChangeTrustOp
      attribute :allow_trust_op,  AllowTrustOp
      attribute :destination,     Uint256
      attribute :inflation_seq,   Uint32
    end
  end
end
