# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ConfigSettingEntry
#   {
#       union switch (int v)
#       {
#       case 0:
#           void;
#       }
#       ext;
#   
#       ConfigSettingID configSettingID;
#       ConfigSetting setting;
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :ext,               Ext
    attribute :config_setting_id, ConfigSettingID
    attribute :setting,           ConfigSetting
  end
end
