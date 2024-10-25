# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           ConfigSettingID id; // id to update
#           ConfigSetting setting; // new value
#       }
#
# ===========================================================================
module Stellar
  class LedgerUpgrade
    class ConfigSetting < XDR::Struct
      attribute :id,      ConfigSettingID
      attribute :setting, ConfigSetting
    end
  end
end
