# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct UpgradeEntryMeta
#   {
#       LedgerUpgrade upgrade;
#       LedgerEntryChanges changes;
#   };
#
# ===========================================================================
module Stellar
  class UpgradeEntryMeta < XDR::Struct
    attribute :upgrade, LedgerUpgrade
    attribute :changes, LedgerEntryChanges
  end
end
