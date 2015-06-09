# Automatically generated on 2015-06-09T15:04:05-07:00
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
#       case MANAGE_OFFER:
#           ManageOfferOp manageOfferOp;
#       case CREATE_PASSIVE_OFFER:
#           CreatePassiveOfferOp createPassiveOfferOp;
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

      switch :create_account,       :create_account_op
      switch :payment,              :payment_op
      switch :path_payment,         :path_payment_op
      switch :manage_offer,         :manage_offer_op
      switch :create_passive_offer, :create_passive_offer_op
      switch :set_options,          :set_options_op
      switch :change_trust,         :change_trust_op
      switch :allow_trust,          :allow_trust_op
      switch :account_merge,        :destination
      switch :inflation

      attribute :create_account_op,       CreateAccountOp
      attribute :payment_op,              PaymentOp
      attribute :path_payment_op,         PathPaymentOp
      attribute :manage_offer_op,         ManageOfferOp
      attribute :create_passive_offer_op, CreatePassiveOfferOp
      attribute :set_options_op,          SetOptionsOp
      attribute :change_trust_op,         ChangeTrustOp
      attribute :allow_trust_op,          AllowTrustOp
      attribute :destination,             Uint256
    end
  end
end
