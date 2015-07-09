# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#           {
#               SCPBallot commit; // c
#               uint32 nP;        // n_P
#               // not from the paper, but useful to build tooling to
#               // traverse the graph based off only the latest statement
#               Hash commitQuorumSetHash; // D used before EXTERNALIZE
#           }
#
# ===========================================================================
module Stellar
  class SCPStatement
    class Pledges
      class Externalize < XDR::Struct
        attribute :commit,                 SCPBallot
        attribute :n_p,                    Uint32
        attribute :commit_quorum_set_hash, Hash
      end
    end
  end
end
