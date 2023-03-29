# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerCloseMetaV2
#   {
#       LedgerHeaderHistoryEntry ledgerHeader;
#       
#       GeneralizedTransactionSet txSet;
#   
#       // NB: transactions are sorted in apply order here
#       // fees for all transactions are processed first
#       // followed by applying transactions
#       TransactionResultMetaV2 txProcessing<>;
#   
#       // upgrades are applied last
#       UpgradeEntryMeta upgradesProcessing<>;
#   
#       // other misc information attached to the ledger close
#       SCPHistoryEntry scpInfo<>;
#   };
#
# ===========================================================================
module Stellar
  class LedgerCloseMetaV2 < XDR::Struct
    attribute :ledger_header,       LedgerHeaderHistoryEntry
    attribute :tx_set,              GeneralizedTransactionSet
    attribute :tx_processing,       XDR::VarArray[TransactionResultMetaV2]
    attribute :upgrades_processing, XDR::VarArray[UpgradeEntryMeta]
    attribute :scp_info,            XDR::VarArray[SCPHistoryEntry]
  end
end
