# This code was automatically generated using xdrgen
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
#           AccountID destination;
#       case INFLATION:
#           void;
#       case MANAGE_DATA:
#           ManageDataOp manageDataOp;
#       case BUMP_SEQUENCE:
#           BumpSequenceOp bumpSequenceOp;
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
      switch :manage_data,          :manage_data_op
      switch :bump_sequence,        :bump_sequence_op

      attribute :create_account_op,       CreateAccountOp
      attribute :payment_op,              PaymentOp
      attribute :path_payment_op,         PathPaymentOp
      attribute :manage_offer_op,         ManageOfferOp
      attribute :create_passive_offer_op, CreatePassiveOfferOp
      attribute :set_options_op,          SetOptionsOp
      attribute :change_trust_op,         ChangeTrustOp
      attribute :allow_trust_op,          AllowTrustOp
      attribute :destination,             AccountID
      attribute :manage_data_op,          ManageDataOp
      attribute :bump_sequence_op,        BumpSequenceOp
    end
  end
end
