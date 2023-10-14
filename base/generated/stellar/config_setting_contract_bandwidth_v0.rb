# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ConfigSettingContractBandwidthV0
#   {
#       // Maximum sum of all transaction sizes in the ledger in bytes
#       uint32 ledgerMaxTxsSizeBytes;
#       // Maximum size in bytes for a transaction
#       uint32 txMaxSizeBytes;
#   
#       // Fee for 1 KB of transaction size
#       int64 feeTxSize1KB;
#   };
#
# ===========================================================================
module Stellar
  class ConfigSettingContractBandwidthV0 < XDR::Struct
    attribute :ledger_max_txs_size_bytes, Uint32
    attribute :tx_max_size_bytes,         Uint32
    attribute :fee_tx_size1_kb,           Int64
  end
end
