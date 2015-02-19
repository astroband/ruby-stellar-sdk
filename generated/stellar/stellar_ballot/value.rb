# Automatically generated from xdr/Stellar-overlay.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class StellarBallot
    class Value < XDR::Struct

                              
      attribute :tx_set_hash, Hash
      attribute :close_time,  Uint64
      attribute :base_fee,    Int64
    end
  end
end
