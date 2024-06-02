# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ConfigSettingContractEventsV0
#   {
#       // Maximum size of events that a contract call can emit.
#       uint32 txMaxContractEventsSizeBytes;
#       // Fee for generating 1KB of contract events.
#       int64 feeContractEvents1KB;
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingContractEventsV0 < XDR::Struct
    attribute :tx_max_contract_events_size_bytes, Uint32
    attribute :fee_contract_events1_kb,           Int64
  end
end
