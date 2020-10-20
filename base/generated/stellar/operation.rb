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
#       MuxedAccount* sourceAccount;
#   
#       union switch (OperationType type)
#       {
#       case CREATE_ACCOUNT:
#           CreateAccountOp createAccountOp;
#       case PAYMENT:
#           PaymentOp paymentOp;
#       case PATH_PAYMENT_STRICT_RECEIVE:
#           PathPaymentStrictReceiveOp pathPaymentStrictReceiveOp;
#       case MANAGE_SELL_OFFER:
#           ManageSellOfferOp manageSellOfferOp;
#       case CREATE_PASSIVE_SELL_OFFER:
#           CreatePassiveSellOfferOp createPassiveSellOfferOp;
#       case SET_OPTIONS:
#           SetOptionsOp setOptionsOp;
#       case CHANGE_TRUST:
#           ChangeTrustOp changeTrustOp;
#       case ALLOW_TRUST:
#           AllowTrustOp allowTrustOp;
#       case ACCOUNT_MERGE:
#           MuxedAccount destination;
#       case INFLATION:
#           void;
#       case MANAGE_DATA:
#           ManageDataOp manageDataOp;
#       case BUMP_SEQUENCE:
#           BumpSequenceOp bumpSequenceOp;
#       case MANAGE_BUY_OFFER:
#           ManageBuyOfferOp manageBuyOfferOp;
#       case PATH_PAYMENT_STRICT_SEND:
#           PathPaymentStrictSendOp pathPaymentStrictSendOp;
#       case CREATE_CLAIMABLE_BALANCE:
#           CreateClaimableBalanceOp createClaimableBalanceOp;
#       case CLAIM_CLAIMABLE_BALANCE:
#           ClaimClaimableBalanceOp claimClaimableBalanceOp;
#       case BEGIN_SPONSORING_FUTURE_RESERVES:
#           BeginSponsoringFutureReservesOp beginSponsoringFutureReservesOp;
#       case END_SPONSORING_FUTURE_RESERVES:
#           void;
#       case REVOKE_SPONSORSHIP:
#           RevokeSponsorshipOp revokeSponsorshipOp;
#       }
#       body;
#   };
#
# ===========================================================================
module Stellar
  class Operation < XDR::Struct
    include XDR::Namespace

    autoload :Body

    attribute :source_account, XDR::Option[MuxedAccount]
    attribute :body,           Body
  end
end
