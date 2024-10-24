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
#       LEDGER_UPGRADE_BASE_RESERVE = 4,
#       LEDGER_UPGRADE_FLAGS = 5,
#       LEDGER_UPGRADE_CONFIG = 6,
#       LEDGER_UPGRADE_MAX_SOROBAN_TX_SET_SIZE = 7
#   };
#
# ===========================================================================
module Stellar
  class LedgerUpgradeType < XDR::Enum
    member :ledger_upgrade_version,                 1
    member :ledger_upgrade_base_fee,                2
    member :ledger_upgrade_max_tx_set_size,         3
    member :ledger_upgrade_base_reserve,            4
    member :ledger_upgrade_flags,                   5
    member :ledger_upgrade_config,                  6
    member :ledger_upgrade_max_soroban_tx_set_size, 7

    seal
  end
end
