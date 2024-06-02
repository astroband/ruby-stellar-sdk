# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct FloodAdvert
#   {
#       TxAdvertVector txHashes;
#   };
#
# ===========================================================================
module Stellar
  class FloodAdvert < XDR::Struct
    attribute :tx_hashes, TxAdvertVector
  end
end
