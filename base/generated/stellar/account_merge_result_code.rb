# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum AccountMergeResultCode
#   {
#       // codes considered as "success" for the operation
#       ACCOUNT_MERGE_SUCCESS = 0,
#       // codes considered as "failure" for the operation
#       ACCOUNT_MERGE_MALFORMED = -1,       // can't merge onto itself
#       ACCOUNT_MERGE_NO_ACCOUNT = -2,      // destination does not exist
#       ACCOUNT_MERGE_IMMUTABLE_SET = -3,   // source account has AUTH_IMMUTABLE set
#       ACCOUNT_MERGE_HAS_SUB_ENTRIES = -4, // account has trust lines/offers
#       ACCOUNT_MERGE_SEQNUM_TOO_FAR = -5,  // sequence number is over max allowed
#       ACCOUNT_MERGE_DEST_FULL = -6        // can't add source balance to
#                                           // destination balance
#   };
#
# ===========================================================================
module Stellar
  class AccountMergeResultCode < XDR::Enum
    member :account_merge_success,         0
    member :account_merge_malformed,       -1
    member :account_merge_no_account,      -2
    member :account_merge_immutable_set,   -3
    member :account_merge_has_sub_entries, -4
    member :account_merge_seqnum_too_far,  -5
    member :account_merge_dest_full,       -6

    seal
  end
end
