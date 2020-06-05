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
#       default:
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
