# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct FloodDemand
#   {
#       TxDemandVector txHashes;
#   };
#
# ===========================================================================
module Stellar
  class FloodDemand < XDR::Struct
    attribute :tx_hashes, TxDemandVector
  end
end
