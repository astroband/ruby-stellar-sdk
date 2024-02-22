# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ConfigSettingContractExecutionLanesV0
#   {
#       // maximum number of Soroban transactions per ledger
#       uint32 ledgerMaxTxCount;
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingContractExecutionLanesV0 < XDR::Struct
    attribute :ledger_max_tx_count, Uint32
  end
end
