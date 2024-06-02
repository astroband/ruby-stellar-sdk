# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ConfigSettingType
#   {
#       CONFIG_SETTING_TYPE_UINT32 = 0
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingType < XDR::Enum
    member :config_setting_type_uint32, 0

    seal
  end
end
