# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ConfigUpgradeSet {
#       ConfigSettingEntry updatedEntry<>;
#   };
#
# ===========================================================================
module Stellar
  class ConfigUpgradeSet < XDR::Struct
    attribute :updated_entry, XDR::VarArray[ConfigSettingEntry]
  end
end
