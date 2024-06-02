# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ConfigSettingContractComputeV0
#   {
#       // Maximum instructions per ledger
#       int64 ledgerMaxInstructions;
#       // Maximum instructions per transaction
#       int64 txMaxInstructions;
#       // Cost of 10000 instructions
#       int64 feeRatePerInstructionsIncrement;
#   
#       // Memory limit per transaction. Unlike instructions, there is no fee
#       // for memory, just the limit.
#       uint32 txMemoryLimit;
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingContractComputeV0 < XDR::Struct
    attribute :ledger_max_instructions,             Int64
    attribute :tx_max_instructions,                 Int64
    attribute :fee_rate_per_instructions_increment, Int64
    attribute :tx_memory_limit,                     Uint32
  end
end
