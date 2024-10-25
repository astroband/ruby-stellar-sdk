# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (TransactionResultCode code)
#       {
#       case txFEE_BUMP_INNER_SUCCESS:
#       case txFEE_BUMP_INNER_FAILED:
#           InnerTransactionResultPair innerResultPair;
#       case txSUCCESS:
#       case txFAILED:
#           OperationResult results<>;
#       case txTOO_EARLY:
#       case txTOO_LATE:
#       case txMISSING_OPERATION:
#       case txBAD_SEQ:
#       case txBAD_AUTH:
#       case txINSUFFICIENT_BALANCE:
#       case txNO_ACCOUNT:
#       case txINSUFFICIENT_FEE:
#       case txBAD_AUTH_EXTRA:
#       case txINTERNAL_ERROR:
#       case txNOT_SUPPORTED:
#       // case txFEE_BUMP_INNER_FAILED: handled above
#       case txBAD_SPONSORSHIP:
#       case txBAD_MIN_SEQ_AGE_OR_GAP:
#       case txMALFORMED:
#           void;
#       }
#
# ===========================================================================
module Stellar
  class TransactionResult
    class Result < XDR::Union
      switch_on TransactionResultCode, :code

      switch :tx_fee_bump_inner_success, :inner_result_pair
      switch :tx_fee_bump_inner_failed,  :inner_result_pair
      switch :tx_success,                :results
      switch :tx_failed,                 :results
      switch :tx_too_early
      switch :tx_too_late
      switch :tx_missing_operation
      switch :tx_bad_seq
      switch :tx_bad_auth
      switch :tx_insufficient_balance
      switch :tx_no_account
      switch :tx_insufficient_fee
      switch :tx_bad_auth_extra
      switch :tx_internal_error
      switch :tx_not_supported
      switch :tx_bad_sponsorship
      switch :tx_bad_min_seq_age_or_gap
      switch :tx_malformed

      attribute :inner_result_pair, InnerTransactionResultPair
      attribute :results,           XDR::VarArray[OperationResult]
    end
  end
end
