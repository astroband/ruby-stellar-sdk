# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResultPair
#   {
#       Hash transactionHash;
#       TransactionResult result; // result for the transaction
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultPair < XDR::Struct
    attribute :transaction_hash, Hash
    attribute :result,           TransactionResult
  end
end
