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
#   case LEDGER_UPGRADE_FLAGS:
#       uint32 newFlags; // update flags
#   case LEDGER_UPGRADE_CONFIG:
#       struct
#       {
#           ConfigSettingID id; // id to update
#           ConfigSetting setting; // new value
#       } configSetting;
#   };
#
# ===========================================================================
module Stellar
  class LedgerUpgrade < XDR::Union
    include XDR::Namespace

    autoload :ConfigSetting

    switch_on LedgerUpgradeType, :type

    switch :ledger_upgrade_version,         :new_ledger_version
    switch :ledger_upgrade_base_fee,        :new_base_fee
    switch :ledger_upgrade_max_tx_set_size, :new_max_tx_set_size
    switch :ledger_upgrade_base_reserve,    :new_base_reserve
    switch :ledger_upgrade_flags,           :new_flags
    switch :ledger_upgrade_config,          :config_setting

    attribute :new_ledger_version,  Uint32
    attribute :new_base_fee,        Uint32
    attribute :new_max_tx_set_size, Uint32
    attribute :new_base_reserve,    Uint32
    attribute :new_flags,           Uint32
    attribute :config_setting,      ConfigSetting
  end
end
