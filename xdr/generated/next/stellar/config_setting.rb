# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ConfigSetting switch (ConfigSettingType type)
#   {
#   case CONFIG_SETTING_TYPE_UINT32:
#       uint32 uint32Val;
#   };
#
# ===========================================================================
module Stellar
  class ConfigSetting < XDR::Union
    switch_on ConfigSettingType, :type

    switch :config_setting_type_uint32, :uint32_val

    attribute :uint32_val, Uint32
  end
end
