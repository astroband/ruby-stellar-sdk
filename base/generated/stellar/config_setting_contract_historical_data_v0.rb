# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ConfigSettingContractHistoricalDataV0
#   {
#       int64 feeHistorical1KB; // Fee for storing 1KB in archives
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingContractHistoricalDataV0 < XDR::Struct
    attribute :fee_historical1_kb, Int64
  end
end
