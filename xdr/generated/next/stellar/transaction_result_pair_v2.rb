# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResultPairV2
#   {
#       Hash transactionHash;
#       Hash hashOfMetaHashes; // hash of hashes in TransactionMetaV3
#                              // TransactionResult is in the meta
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultPairV2 < XDR::Struct
    attribute :transaction_hash,    Hash
    attribute :hash_of_meta_hashes, Hash
  end
end
