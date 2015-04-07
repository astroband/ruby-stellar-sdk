# Automatically generated on 2015-04-07T10:52:07-07:00
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
