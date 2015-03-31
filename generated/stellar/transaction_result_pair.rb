# Automatically generated on 2015-03-31T14:32:44-07:00
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
