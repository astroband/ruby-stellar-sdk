# Automatically generated on 2015-05-07T07:56:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum TransactionResultCode
#   {
#       txSUCCESS = 0, // all operations succeeded
#   
#       txDUPLICATE = -1, // transaction was already submited
#   
#       txFAILED = -2, // one of the operations failed (but none were applied)
#   
#       txBAD_LEDGER = -3,        // ledger is not in range [minLeder; maxLedger]
#       txMISSING_OPERATION = -4, // no operation was specified
#       txBAD_SEQ = -5,           // sequence number does not match source account
#   
#       txBAD_AUTH = -6,             // not enough signatures to perform transaction
#       txINSUFFICIENT_BALANCE = -7, // fee would bring account below reserve
#       txNO_ACCOUNT = -8,           // source account not found
#       txINSUFFICIENT_FEE = -9,     // max fee is too small
#       txBAD_AUTH_EXTRA = -10,      // too many signatures on transaction
#       txINTERNAL_ERROR = -11       // an unknown error occured
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultCode < XDR::Enum
    member :tx_success,              0
    member :tx_duplicate,            -1
    member :tx_failed,               -2
    member :tx_bad_ledger,           -3
    member :tx_missing_operation,    -4
    member :tx_bad_seq,              -5
    member :tx_bad_auth,             -6
    member :tx_insufficient_balance, -7
    member :tx_no_account,           -8
    member :tx_insufficient_fee,     -9
    member :tx_bad_auth_extra,       -10
    member :tx_internal_error,       -11

    seal
  end
end
