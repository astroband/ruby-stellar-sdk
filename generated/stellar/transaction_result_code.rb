# Automatically generated on 2015-05-13T15:00:04-07:00
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
#       txTOO_EARLY = -3,         // ledger closeTime before minTime
#       txTOO_LATE = -4,          // ledger closeTime after maxTime
#       txMISSING_OPERATION = -5, // no operation was specified
#       txBAD_SEQ = -6,           // sequence number does not match source account
#   
#       txBAD_AUTH = -7,             // not enough signatures to perform transaction
#       txINSUFFICIENT_BALANCE = -8, // fee would bring account below reserve
#       txNO_ACCOUNT = -9,           // source account not found
#       txINSUFFICIENT_FEE = -10,    // fee is too small
#       txBAD_AUTH_EXTRA = -11,      // too many signatures on transaction
#       txINTERNAL_ERROR = -12       // an unknown error occured
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultCode < XDR::Enum
    member :tx_success,              0
    member :tx_duplicate,            -1
    member :tx_failed,               -2
    member :tx_too_early,            -3
    member :tx_too_late,             -4
    member :tx_missing_operation,    -5
    member :tx_bad_seq,              -6
    member :tx_bad_auth,             -7
    member :tx_insufficient_balance, -8
    member :tx_no_account,           -9
    member :tx_insufficient_fee,     -10
    member :tx_bad_auth_extra,       -11
    member :tx_internal_error,       -12

    seal
  end
end
