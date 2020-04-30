# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union LedgerUpgrade switch (LedgerUpgradeType type)
#   {
#   case LEDGER_UPGRADE_VERSION:
#       uint32 newLedgerVersion; // update ledgerVersion
#   case LEDGER_UPGRADE_BASE_FEE:
#       uint32 newBaseFee; // update baseFee
#   case LEDGER_UPGRADE_MAX_TX_SET_SIZE:
#       uint32 newMaxTxSetSize; // update maxTxSetSize
#   case LEDGER_UPGRADE_BASE_RESERVE:
#       uint32 newBaseReserve; // update baseReserve
#   };
#
# ===========================================================================
module Stellar
  class LedgerUpgrade < XDR::Union
    switch_on LedgerUpgradeType, :type

    switch :ledger_upgrade_version,         :new_ledger_version
    switch :ledger_upgrade_base_fee,        :new_base_fee
    switch :ledger_upgrade_max_tx_set_size, :new_max_tx_set_size
    switch :ledger_upgrade_base_reserve,    :new_base_reserve

    attribute :new_ledger_version,  Uint32
    attribute :new_base_fee,        Uint32
    attribute :new_max_tx_set_size, Uint32
    attribute :new_base_reserve,    Uint32
  end
end
