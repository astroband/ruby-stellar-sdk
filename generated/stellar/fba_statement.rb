# Automatically generated from xdr/FBAXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class FBAStatement < XDR::Struct
    include XDR::Namespace

    autoload :Pledges
                                
    attribute :slot_index,      Uint64
    attribute :ballot,          FBABallot
    attribute :quorum_set_hash, Hash
    attribute :pledges,         Pledges
  end
end
