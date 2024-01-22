# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ConfigSettingID
#   {
#       CONFIG_SETTING_CONTRACT_MAX_SIZE_BYTES = 0,
#       CONFIG_SETTING_CONTRACT_COMPUTE_V0 = 1,
#       CONFIG_SETTING_CONTRACT_LEDGER_COST_V0 = 2,
#       CONFIG_SETTING_CONTRACT_HISTORICAL_DATA_V0 = 3,
#       CONFIG_SETTING_CONTRACT_EVENTS_V0 = 4,
#       CONFIG_SETTING_CONTRACT_BANDWIDTH_V0 = 5,
#       CONFIG_SETTING_CONTRACT_COST_PARAMS_CPU_INSTRUCTIONS = 6,
#       CONFIG_SETTING_CONTRACT_COST_PARAMS_MEMORY_BYTES = 7,
#       CONFIG_SETTING_CONTRACT_DATA_KEY_SIZE_BYTES = 8,
#       CONFIG_SETTING_CONTRACT_DATA_ENTRY_SIZE_BYTES = 9,
#       CONFIG_SETTING_STATE_ARCHIVAL = 10,
#       CONFIG_SETTING_CONTRACT_EXECUTION_LANES = 11,
#       CONFIG_SETTING_BUCKETLIST_SIZE_WINDOW = 12,
#       CONFIG_SETTING_EVICTION_ITERATOR = 13
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingID < XDR::Enum
    member :config_setting_contract_max_size_bytes,               0
    member :config_setting_contract_compute_v0,                   1
    member :config_setting_contract_ledger_cost_v0,               2
    member :config_setting_contract_historical_data_v0,           3
    member :config_setting_contract_events_v0,                    4
    member :config_setting_contract_bandwidth_v0,                 5
    member :config_setting_contract_cost_params_cpu_instructions, 6
    member :config_setting_contract_cost_params_memory_bytes,     7
    member :config_setting_contract_data_key_size_bytes,          8
    member :config_setting_contract_data_entry_size_bytes,        9
    member :config_setting_state_archival,                        10
    member :config_setting_contract_execution_lanes,              11
    member :config_setting_bucketlist_size_window,                12
    member :config_setting_eviction_iterator,                     13

    seal
  end
end
