# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum LedgerUpgradeType
#   {
#       LEDGER_UPGRADE_VERSION = 1,
#       LEDGER_UPGRADE_BASE_FEE = 2,
#       LEDGER_UPGRADE_MAX_TX_SET_SIZE = 3,
#       LEDGER_UPGRADE_BASE_RESERVE = 4
#   };
#
# ===========================================================================
module StellarProtocol
  class LedgerUpgradeType < XDR::Enum
    member :ledger_upgrade_version,         1
    member :ledger_upgrade_base_fee,        2
    member :ledger_upgrade_max_tx_set_size, 3
    member :ledger_upgrade_base_reserve,    4

    seal
  end
end
