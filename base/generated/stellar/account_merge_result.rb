# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union AccountMergeResult switch (AccountMergeResultCode code)
#   {
#   case ACCOUNT_MERGE_SUCCESS:
#       int64 sourceAccountBalance; // how much got transfered from source account
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class AccountMergeResult < XDR::Union
    switch_on AccountMergeResultCode, :code

    switch :account_merge_success, :source_account_balance
    switch :default

    attribute :source_account_balance, Int64
  end
end
