# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union switch (OperationType type)
#       {
#       case CREATE_ACCOUNT:
#           CreateAccountOp createAccountOp;
#       case PAYMENT:
#           PaymentOp paymentOp;
#       case PATH_PAYMENT:
#           PathPaymentOp pathPaymentOp;
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

      switch :create_account, :create_account_op
      switch :payment,        :payment_op
      switch :path_payment,   :path_payment_op
      switch :create_offer,   :create_offer_op
      switch :set_options,    :set_options_op
      switch :change_trust,   :change_trust_op
      switch :allow_trust,    :allow_trust_op
      switch :account_merge,  :destination
      switch :inflation

      attribute :create_account_op, CreateAccountOp
      attribute :payment_op,        PaymentOp
      attribute :path_payment_op,   PathPaymentOp
      attribute :create_offer_op,   CreateOfferOp
      attribute :set_options_op,    SetOptionsOp
      attribute :change_trust_op,   ChangeTrustOp
      attribute :allow_trust_op,    AllowTrustOp
      attribute :destination,       Uint256
    end
  end
end
