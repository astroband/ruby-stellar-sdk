# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct InnerTransactionResultPair
#   {
#       Hash transactionHash;          // hash of the inner transaction
#       InnerTransactionResult result; // result for the inner transaction
#   };
#
# ===========================================================================
module Stellar
  class InnerTransactionResultPair < XDR::Struct
    attribute :transaction_hash, Hash
    attribute :result,           InnerTransactionResult
  end
end
