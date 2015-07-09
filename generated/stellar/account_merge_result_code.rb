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
#       ACCOUNT_MERGE_MALFORMED = -1,  // can't merge onto itself
#       ACCOUNT_MERGE_NO_ACCOUNT = -2, // destination does not exist
#       ACCOUNT_MERGE_HAS_CREDIT = -3, // account has active trust lines
#       ACCOUNT_MERGE_CREDIT_HELD = -4 // an issuer cannot be merged if used
#   };
#
# ===========================================================================
module Stellar
  class AccountMergeResultCode < XDR::Enum
    member :account_merge_success,     0
    member :account_merge_malformed,   -1
    member :account_merge_no_account,  -2
    member :account_merge_has_credit,  -3
    member :account_merge_credit_held, -4

    seal
  end
end
