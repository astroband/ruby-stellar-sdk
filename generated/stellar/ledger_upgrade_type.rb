# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum LedgerUpgradeType
#   {
#       LEDGER_UPGRADE_VERSION = 1,
#       LEDGER_UPGRADE_BASE_FEE = 2
#   };
#
# ===========================================================================
module Stellar
  class LedgerUpgradeType < XDR::Enum
    member :ledger_upgrade_version,  1
    member :ledger_upgrade_base_fee, 2

    seal
  end
end
