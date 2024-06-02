# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ConfigSettingID
#   {
#       CONFIG_SETTING_CONTRACT_MAX_SIZE = 0
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingID < XDR::Enum
    member :config_setting_contract_max_size, 0

    seal
  end
end
