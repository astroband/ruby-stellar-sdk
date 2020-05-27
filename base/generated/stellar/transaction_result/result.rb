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
#       default:
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
      switch :default

      attribute :inner_result_pair, InnerTransactionResultPair
      attribute :results,           XDR::VarArray[OperationResult]
    end
  end
end
