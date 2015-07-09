# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union OperationResult switch (OperationResultCode code)
#   {
#   case opINNER:
#       union switch (OperationType type)
#       {
#       case CREATE_ACCOUNT:
#           CreateAccountResult createAccountResult;
#       case PAYMENT:
#           PaymentResult paymentResult;
#       case PATH_PAYMENT:
#           PathPaymentResult pathPaymentResult;
#       case MANAGE_OFFER:
#           ManageOfferResult manageOfferResult;
#       case CREATE_PASSIVE_OFFER:
#           ManageOfferResult createPassiveOfferResult;
#       case SET_OPTIONS:
#           SetOptionsResult setOptionsResult;
#       case CHANGE_TRUST:
#           ChangeTrustResult changeTrustResult;
#       case ALLOW_TRUST:
#           AllowTrustResult allowTrustResult;
#       case ACCOUNT_MERGE:
#           AccountMergeResult accountMergeResult;
#       case INFLATION:
#           InflationResult inflationResult;
#       }
#       tr;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class OperationResult < XDR::Union
    include XDR::Namespace

    autoload :Tr

    switch_on OperationResultCode, :code

    switch :op_inner, :tr
    switch :default

    attribute :tr, Tr
  end
end
