# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#           {
#               SCPBallot commit;         // c
#               uint32 nH;                // h.n
#               Hash commitQuorumSetHash; // D used before EXTERNALIZE
#           }
#
# ===========================================================================
module StellarProtocol
  class SCPStatement
    class Pledges
      class Externalize < XDR::Struct
        attribute :commit,                 SCPBallot
        attribute :n_h,                    Uint32
        attribute :commit_quorum_set_hash, Hash
      end
    end
  end
end
