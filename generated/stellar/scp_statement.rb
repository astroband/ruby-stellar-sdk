# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class SCPStatement < XDR::Struct
    include XDR::Namespace

    autoload :Pledges

    attribute :slot_index,      Uint64
    attribute :ballot,          SCPBallot
    attribute :quorum_set_hash, Hash
    attribute :pledges,         Pledges
  end
end
