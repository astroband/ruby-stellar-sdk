# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           ConfigSettingID configSettingID;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class ConfigSetting < XDR::Struct
      attribute :config_setting_id, ConfigSettingID
    end
  end
end
