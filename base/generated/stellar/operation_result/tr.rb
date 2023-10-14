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
#       case CREATE_CLAIMABLE_BALANCE:
#           CreateClaimableBalanceResult createClaimableBalanceResult;
#       case CLAIM_CLAIMABLE_BALANCE:
#           ClaimClaimableBalanceResult claimClaimableBalanceResult;
#       case BEGIN_SPONSORING_FUTURE_RESERVES:
#           BeginSponsoringFutureReservesResult beginSponsoringFutureReservesResult;
#       case END_SPONSORING_FUTURE_RESERVES:
#           EndSponsoringFutureReservesResult endSponsoringFutureReservesResult;
#       case REVOKE_SPONSORSHIP:
#           RevokeSponsorshipResult revokeSponsorshipResult;
#       case CLAWBACK:
#           ClawbackResult clawbackResult;
#       case CLAWBACK_CLAIMABLE_BALANCE:
#           ClawbackClaimableBalanceResult clawbackClaimableBalanceResult;
#       case SET_TRUST_LINE_FLAGS:
#           SetTrustLineFlagsResult setTrustLineFlagsResult;
#       case LIQUIDITY_POOL_DEPOSIT:
#           LiquidityPoolDepositResult liquidityPoolDepositResult;
#       case LIQUIDITY_POOL_WITHDRAW:
#           LiquidityPoolWithdrawResult liquidityPoolWithdrawResult;
#       case INVOKE_HOST_FUNCTION:
#           InvokeHostFunctionResult invokeHostFunctionResult;
#       case BUMP_FOOTPRINT_EXPIRATION:
#           BumpFootprintExpirationResult bumpFootprintExpirationResult;
#       case RESTORE_FOOTPRINT:
#           RestoreFootprintResult restoreFootprintResult;
#       }
#
# ===========================================================================
module Stellar
  class OperationResult
    class Tr < XDR::Union
      switch_on OperationType, :type

      switch :create_account,                   :create_account_result
      switch :payment,                          :payment_result
      switch :path_payment_strict_receive,      :path_payment_strict_receive_result
      switch :manage_sell_offer,                :manage_sell_offer_result
      switch :create_passive_sell_offer,        :create_passive_sell_offer_result
      switch :set_options,                      :set_options_result
      switch :change_trust,                     :change_trust_result
      switch :allow_trust,                      :allow_trust_result
      switch :account_merge,                    :account_merge_result
      switch :inflation,                        :inflation_result
      switch :manage_data,                      :manage_data_result
      switch :bump_sequence,                    :bump_seq_result
      switch :manage_buy_offer,                 :manage_buy_offer_result
      switch :path_payment_strict_send,         :path_payment_strict_send_result
      switch :create_claimable_balance,         :create_claimable_balance_result
      switch :claim_claimable_balance,          :claim_claimable_balance_result
      switch :begin_sponsoring_future_reserves, :begin_sponsoring_future_reserves_result
      switch :end_sponsoring_future_reserves,   :end_sponsoring_future_reserves_result
      switch :revoke_sponsorship,               :revoke_sponsorship_result
      switch :clawback,                         :clawback_result
      switch :clawback_claimable_balance,       :clawback_claimable_balance_result
      switch :set_trust_line_flags,             :set_trust_line_flags_result
      switch :liquidity_pool_deposit,           :liquidity_pool_deposit_result
      switch :liquidity_pool_withdraw,          :liquidity_pool_withdraw_result
      switch :invoke_host_function,             :invoke_host_function_result
      switch :bump_footprint_expiration,        :bump_footprint_expiration_result
      switch :restore_footprint,                :restore_footprint_result

      attribute :create_account_result,                   CreateAccountResult
      attribute :payment_result,                          PaymentResult
      attribute :path_payment_strict_receive_result,      PathPaymentStrictReceiveResult
      attribute :manage_sell_offer_result,                ManageSellOfferResult
      attribute :create_passive_sell_offer_result,        ManageSellOfferResult
      attribute :set_options_result,                      SetOptionsResult
      attribute :change_trust_result,                     ChangeTrustResult
      attribute :allow_trust_result,                      AllowTrustResult
      attribute :account_merge_result,                    AccountMergeResult
      attribute :inflation_result,                        InflationResult
      attribute :manage_data_result,                      ManageDataResult
      attribute :bump_seq_result,                         BumpSequenceResult
      attribute :manage_buy_offer_result,                 ManageBuyOfferResult
      attribute :path_payment_strict_send_result,         PathPaymentStrictSendResult
      attribute :create_claimable_balance_result,         CreateClaimableBalanceResult
      attribute :claim_claimable_balance_result,          ClaimClaimableBalanceResult
      attribute :begin_sponsoring_future_reserves_result, BeginSponsoringFutureReservesResult
      attribute :end_sponsoring_future_reserves_result,   EndSponsoringFutureReservesResult
      attribute :revoke_sponsorship_result,               RevokeSponsorshipResult
      attribute :clawback_result,                         ClawbackResult
      attribute :clawback_claimable_balance_result,       ClawbackClaimableBalanceResult
      attribute :set_trust_line_flags_result,             SetTrustLineFlagsResult
      attribute :liquidity_pool_deposit_result,           LiquidityPoolDepositResult
      attribute :liquidity_pool_withdraw_result,          LiquidityPoolWithdrawResult
      attribute :invoke_host_function_result,             InvokeHostFunctionResult
      attribute :bump_footprint_expiration_result,        BumpFootprintExpirationResult
      attribute :restore_footprint_result,                RestoreFootprintResult
    end
  end
end
