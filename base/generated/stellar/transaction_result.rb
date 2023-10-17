# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResult
#   {
#       int64 feeCharged; // actual fee charged for the transaction
#
#       union switch (TransactionResultCode code)
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
#       case txSOROBAN_INVALID:
#           void;
#       }
#       result;
#
#       // reserved for future use
#       union switch (int v)
#       {
#       case 0:
#           void;
#       }
#       ext;
#   };
#
# ===========================================================================
module Stellar
  class TransactionResult < XDR::Struct
    include XDR::Namespace

    autoload :Result
    autoload :Ext

    attribute :fee_charged, Int64
    attribute :result,      Result
    attribute :ext,         Ext
  end
end
