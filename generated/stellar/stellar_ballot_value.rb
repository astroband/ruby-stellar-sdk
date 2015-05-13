# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct StellarBallotValue
#   {
#       Hash txSetHash;
#       uint64 closeTime;
#       uint32 baseFee;
#   };
#
# ===========================================================================
module Stellar
  class StellarBallotValue < XDR::Struct
    attribute :tx_set_hash, Hash
    attribute :close_time,  Uint64
    attribute :base_fee,    Uint32
  end
end
