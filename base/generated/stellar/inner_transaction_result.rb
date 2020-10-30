# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct InnerTransactionResult
#   {
#       // Always 0. Here for binary compatibility.
#       int64 feeCharged;
#   
#       union switch (TransactionResultCode code)
#       {
#       // txFEE_BUMP_INNER_SUCCESS is not included
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
#       // txFEE_BUMP_INNER_FAILED is not included
#       case txBAD_SPONSORSHIP:
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
  class InnerTransactionResult < XDR::Struct
    include XDR::Namespace

    autoload :Result
    autoload :Ext

    attribute :fee_charged, Int64
    attribute :result,      Result
    attribute :ext,         Ext
  end
end
