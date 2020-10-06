# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum TransactionResultCode
#   {
#       txFEE_BUMP_INNER_SUCCESS = 1, // fee bump inner transaction succeeded
#       txSUCCESS = 0,                // all operations succeeded
#   
#       txFAILED = -1, // one of the operations failed (none were applied)
#   
#       txTOO_EARLY = -2,         // ledger closeTime before minTime
#       txTOO_LATE = -3,          // ledger closeTime after maxTime
#       txMISSING_OPERATION = -4, // no operation was specified
#       txBAD_SEQ = -5,           // sequence number does not match source account
#   
#       txBAD_AUTH = -6,             // too few valid signatures / wrong network
#       txINSUFFICIENT_BALANCE = -7, // fee would bring account below reserve
#       txNO_ACCOUNT = -8,           // source account not found
#       txINSUFFICIENT_FEE = -9,     // fee is too small
#       txBAD_AUTH_EXTRA = -10,      // unused signatures attached to transaction
#       txINTERNAL_ERROR = -11,      // an unknown error occured
#   
#       txNOT_SUPPORTED = -12,         // transaction type not supported
#       txFEE_BUMP_INNER_FAILED = -13, // fee bump inner transaction failed
#       txBAD_SPONSORSHIP = -14        // sponsorship not confirmed
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultCode < XDR::Enum
    member :tx_fee_bump_inner_success, 1
    member :tx_success,                0
    member :tx_failed,                 -1
    member :tx_too_early,              -2
    member :tx_too_late,               -3
    member :tx_missing_operation,      -4
    member :tx_bad_seq,                -5
    member :tx_bad_auth,               -6
    member :tx_insufficient_balance,   -7
    member :tx_no_account,             -8
    member :tx_insufficient_fee,       -9
    member :tx_bad_auth_extra,         -10
    member :tx_internal_error,         -11
    member :tx_not_supported,          -12
    member :tx_fee_bump_inner_failed,  -13
    member :tx_bad_sponsorship,        -14

    seal
  end
end
