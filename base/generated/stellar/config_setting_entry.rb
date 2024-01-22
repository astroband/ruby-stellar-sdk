# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ConfigSettingEntry switch (ConfigSettingID configSettingID)
#   {
#   case CONFIG_SETTING_CONTRACT_MAX_SIZE_BYTES:
#       uint32 contractMaxSizeBytes;
#   case CONFIG_SETTING_CONTRACT_COMPUTE_V0:
#       ConfigSettingContractComputeV0 contractCompute;
#   case CONFIG_SETTING_CONTRACT_LEDGER_COST_V0:
#       ConfigSettingContractLedgerCostV0 contractLedgerCost;
#   case CONFIG_SETTING_CONTRACT_HISTORICAL_DATA_V0:
#       ConfigSettingContractHistoricalDataV0 contractHistoricalData;
#   case CONFIG_SETTING_CONTRACT_EVENTS_V0:
#       ConfigSettingContractEventsV0 contractEvents;
#   case CONFIG_SETTING_CONTRACT_BANDWIDTH_V0:
#       ConfigSettingContractBandwidthV0 contractBandwidth;
#   case CONFIG_SETTING_CONTRACT_COST_PARAMS_CPU_INSTRUCTIONS:
#       ContractCostParams contractCostParamsCpuInsns;
#   case CONFIG_SETTING_CONTRACT_COST_PARAMS_MEMORY_BYTES:
#       ContractCostParams contractCostParamsMemBytes;
#   case CONFIG_SETTING_CONTRACT_DATA_KEY_SIZE_BYTES:
#       uint32 contractDataKeySizeBytes;
#   case CONFIG_SETTING_CONTRACT_DATA_ENTRY_SIZE_BYTES:
#       uint32 contractDataEntrySizeBytes;
#   case CONFIG_SETTING_STATE_ARCHIVAL:
#       StateArchivalSettings stateArchivalSettings;
#   case CONFIG_SETTING_CONTRACT_EXECUTION_LANES:
#       ConfigSettingContractExecutionLanesV0 contractExecutionLanes;
#   case CONFIG_SETTING_BUCKETLIST_SIZE_WINDOW:
#       uint64 bucketListSizeWindow<>;
#   case CONFIG_SETTING_EVICTION_ITERATOR:
#       EvictionIterator evictionIterator;
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingEntry < XDR::Union
    switch_on ConfigSettingID, :configSettingID

    switch :config_setting_contract_max_size_bytes,               :contract_max_size_bytes
    switch :config_setting_contract_compute_v0,                   :contract_compute
    switch :config_setting_contract_ledger_cost_v0,               :contract_ledger_cost
    switch :config_setting_contract_historical_data_v0,           :contract_historical_data
    switch :config_setting_contract_events_v0,                    :contract_events
    switch :config_setting_contract_bandwidth_v0,                 :contract_bandwidth
    switch :config_setting_contract_cost_params_cpu_instructions, :contract_cost_params_cpu_insns
    switch :config_setting_contract_cost_params_memory_bytes,     :contract_cost_params_mem_bytes
    switch :config_setting_contract_data_key_size_bytes,          :contract_data_key_size_bytes
    switch :config_setting_contract_data_entry_size_bytes,        :contract_data_entry_size_bytes
    switch :config_setting_state_archival,                        :state_archival_settings
    switch :config_setting_contract_execution_lanes,              :contract_execution_lanes
    switch :config_setting_bucketlist_size_window,                :bucket_list_size_window
    switch :config_setting_eviction_iterator,                     :eviction_iterator

    attribute :contract_max_size_bytes,        Uint32
    attribute :contract_compute,               ConfigSettingContractComputeV0
    attribute :contract_ledger_cost,           ConfigSettingContractLedgerCostV0
    attribute :contract_historical_data,       ConfigSettingContractHistoricalDataV0
    attribute :contract_events,                ConfigSettingContractEventsV0
    attribute :contract_bandwidth,             ConfigSettingContractBandwidthV0
    attribute :contract_cost_params_cpu_insns, ContractCostParams
    attribute :contract_cost_params_mem_bytes, ContractCostParams
    attribute :contract_data_key_size_bytes,   Uint32
    attribute :contract_data_entry_size_bytes, Uint32
    attribute :state_archival_settings,        StateArchivalSettings
    attribute :contract_execution_lanes,       ConfigSettingContractExecutionLanesV0
    attribute :bucket_list_size_window,        XDR::VarArray[Uint64]
    attribute :eviction_iterator,              EvictionIterator
  end
end
