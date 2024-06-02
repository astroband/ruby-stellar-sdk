# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResultMetaV2
#   {
#       TransactionResultPairV2 result;
#       LedgerEntryChanges feeProcessing;
#       TransactionMeta txApplyProcessing;
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultMetaV2 < XDR::Struct
    attribute :result,              TransactionResultPairV2
    attribute :fee_processing,      LedgerEntryChanges
    attribute :tx_apply_processing, TransactionMeta
  end
end
