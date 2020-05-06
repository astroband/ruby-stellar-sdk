# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (OperationType type)
#       {
#       case CREATE_ACCOUNT:
#           CreateAccountResult createAccountResult;
#       case PAYMENT:
#           PaymentResult paymentResult;
#       case PATH_PAYMENT_STRICT_RECEIVE:
#           PathPaymentStrictReceiveResult pathPaymentStrictReceiveResult;
#       case MANAGE_SELL_OFFER:
#           ManageSellOfferResult manageSellOfferResult;
#       case CREATE_PASSIVE_SELL_OFFER:
#           ManageSellOfferResult createPassiveSellOfferResult;
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
#       case MANAGE_DATA:
#           ManageDataResult manageDataResult;
#       case BUMP_SEQUENCE:
#           BumpSequenceResult bumpSeqResult;
#       case MANAGE_BUY_OFFER:
#           ManageBuyOfferResult manageBuyOfferResult;
#       case PATH_PAYMENT_STRICT_SEND:
#           PathPaymentStrictSendResult pathPaymentStrictSendResult;
#       }
#
# ===========================================================================
module Stellar
  class OperationResult
    class Tr < XDR::Union
      switch_on OperationType, :type

      switch :create_account,              :create_account_result
      switch :payment,                     :payment_result
      switch :path_payment_strict_receive, :path_payment_strict_receive_result
      switch :manage_sell_offer,           :manage_sell_offer_result
      switch :create_passive_sell_offer,   :create_passive_sell_offer_result
      switch :set_options,                 :set_options_result
      switch :change_trust,                :change_trust_result
      switch :allow_trust,                 :allow_trust_result
      switch :account_merge,               :account_merge_result
      switch :inflation,                   :inflation_result
      switch :manage_data,                 :manage_data_result
      switch :bump_sequence,               :bump_seq_result
      switch :manage_buy_offer,            :manage_buy_offer_result
      switch :path_payment_strict_send,    :path_payment_strict_send_result

      attribute :create_account_result,              CreateAccountResult
      attribute :payment_result,                     PaymentResult
      attribute :path_payment_strict_receive_result, PathPaymentStrictReceiveResult
      attribute :manage_sell_offer_result,           ManageSellOfferResult
      attribute :create_passive_sell_offer_result,   ManageSellOfferResult
      attribute :set_options_result,                 SetOptionsResult
      attribute :change_trust_result,                ChangeTrustResult
      attribute :allow_trust_result,                 AllowTrustResult
      attribute :account_merge_result,               AccountMergeResult
      attribute :inflation_result,                   InflationResult
      attribute :manage_data_result,                 ManageDataResult
      attribute :bump_seq_result,                    BumpSequenceResult
      attribute :manage_buy_offer_result,            ManageBuyOfferResult
      attribute :path_payment_strict_send_result,    PathPaymentStrictSendResult
    end
  end
end
