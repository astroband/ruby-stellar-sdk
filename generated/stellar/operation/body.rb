# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union switch (OperationType type)
#       {
#       case PAYMENT:
#           PaymentOp paymentOp;
#       case CREATE_OFFER:
#           CreateOfferOp createOfferOp;
#       case SET_OPTIONS:
#           SetOptionsOp setOptionsOp;
#       case CHANGE_TRUST:
#           ChangeTrustOp changeTrustOp;
#       case ALLOW_TRUST:
#           AllowTrustOp allowTrustOp;
#       case ACCOUNT_MERGE:
#           uint256 destination;
#       case INFLATION:
#           void;
#       }
#
# ===========================================================================
module Stellar
  class Operation
    class Body < XDR::Union
      switch_on OperationType, :type

      switch :payment,       :payment_op
      switch :create_offer,  :create_offer_op
      switch :set_options,   :set_options_op
      switch :change_trust,  :change_trust_op
      switch :allow_trust,   :allow_trust_op
      switch :account_merge, :destination
      switch :inflation

      attribute :payment_op,      PaymentOp
      attribute :create_offer_op, CreateOfferOp
      attribute :set_options_op,  SetOptionsOp
      attribute :change_trust_op, ChangeTrustOp
      attribute :allow_trust_op,  AllowTrustOp
      attribute :destination,     Uint256
    end
  end
end
