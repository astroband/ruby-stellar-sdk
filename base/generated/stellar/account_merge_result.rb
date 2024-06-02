# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union AccountMergeResult switch (AccountMergeResultCode code)
#   {
#   case ACCOUNT_MERGE_SUCCESS:
#       int64 sourceAccountBalance; // how much got transferred from source account
#   case ACCOUNT_MERGE_MALFORMED:
#   case ACCOUNT_MERGE_NO_ACCOUNT:
#   case ACCOUNT_MERGE_IMMUTABLE_SET:
#   case ACCOUNT_MERGE_HAS_SUB_ENTRIES:
#   case ACCOUNT_MERGE_SEQNUM_TOO_FAR:
#   case ACCOUNT_MERGE_DEST_FULL:
#   case ACCOUNT_MERGE_IS_SPONSOR:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class AccountMergeResult < XDR::Union
    switch_on AccountMergeResultCode, :code

    switch :account_merge_success,       :source_account_balance
    switch :account_merge_malformed
    switch :account_merge_no_account
    switch :account_merge_immutable_set
    switch :account_merge_has_sub_entries
    switch :account_merge_seqnum_too_far
    switch :account_merge_dest_full
    switch :account_merge_is_sponsor

    attribute :source_account_balance, Int64
  end
end
