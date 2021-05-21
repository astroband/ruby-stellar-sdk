# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResultMeta
#   {
#       TransactionResultPair result;
#       LedgerEntryChanges feeProcessing;
#       TransactionMeta txApplyProcessing;
#   };
#
# ===========================================================================
module StellarProtocol
  class TransactionResultMeta < XDR::Struct
    attribute :result,              TransactionResultPair
    attribute :fee_processing,      LedgerEntryChanges
    attribute :tx_apply_processing, TransactionMeta
  end
end
