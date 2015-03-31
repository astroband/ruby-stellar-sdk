# Automatically generated on 2015-03-31T14:32:44-07:00
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
#       case txSUCCESS:
#       case txFAILED:
#           OperationResult results<>;
#       default:
#           void;
#       }
#       result;
#   };
#
# ===========================================================================
module Stellar
  class TransactionResult < XDR::Struct
    include XDR::Namespace

    autoload :Result

    attribute :fee_charged, Int64
    attribute :result,      Result
  end
end
