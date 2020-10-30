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
#
# ===========================================================================
module Stellar
  class Operation
    class Body < XDR::Union
      switch_on OperationType, :type

      switch :create_account,                   :create_account_op
      switch :payment,                          :payment_op
      switch :path_payment_strict_receive,      :path_payment_strict_receive_op
      switch :manage_sell_offer,                :manage_sell_offer_op
      switch :create_passive_sell_offer,        :create_passive_sell_offer_op
      switch :set_options,                      :set_options_op
      switch :change_trust,                     :change_trust_op
      switch :allow_trust,                      :allow_trust_op
      switch :account_merge,                    :destination
      switch :inflation
      switch :manage_data,                      :manage_data_op
      switch :bump_sequence,                    :bump_sequence_op
      switch :manage_buy_offer,                 :manage_buy_offer_op
      switch :path_payment_strict_send,         :path_payment_strict_send_op
      switch :create_claimable_balance,         :create_claimable_balance_op
      switch :claim_claimable_balance,          :claim_claimable_balance_op
      switch :begin_sponsoring_future_reserves, :begin_sponsoring_future_reserves_op
      switch :end_sponsoring_future_reserves
      switch :revoke_sponsorship,               :revoke_sponsorship_op

      attribute :create_account_op,                   CreateAccountOp
      attribute :payment_op,                          PaymentOp
      attribute :path_payment_strict_receive_op,      PathPaymentStrictReceiveOp
      attribute :manage_sell_offer_op,                ManageSellOfferOp
      attribute :create_passive_sell_offer_op,        CreatePassiveSellOfferOp
      attribute :set_options_op,                      SetOptionsOp
      attribute :change_trust_op,                     ChangeTrustOp
      attribute :allow_trust_op,                      AllowTrustOp
      attribute :destination,                         MuxedAccount
      attribute :manage_data_op,                      ManageDataOp
      attribute :bump_sequence_op,                    BumpSequenceOp
      attribute :manage_buy_offer_op,                 ManageBuyOfferOp
      attribute :path_payment_strict_send_op,         PathPaymentStrictSendOp
      attribute :create_claimable_balance_op,         CreateClaimableBalanceOp
      attribute :claim_claimable_balance_op,          ClaimClaimableBalanceOp
      attribute :begin_sponsoring_future_reserves_op, BeginSponsoringFutureReservesOp
      attribute :revoke_sponsorship_op,               RevokeSponsorshipOp
    end
  end
end
