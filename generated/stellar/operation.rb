# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Operation
#   {
#       // sourceAccount is the account used to run the operation
#       // if not set, the runtime defaults to "sourceAccount" specified at
#       // the transaction level
#       AccountID* sourceAccount;
#   
#       union switch (OperationType type)
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
#       body;
#   };
#
# ===========================================================================
module Stellar
  class Operation < XDR::Struct
    include XDR::Namespace

    autoload :Body

    attribute :source_account, XDR::Option[AccountID]
    attribute :body,           Body
  end
end
