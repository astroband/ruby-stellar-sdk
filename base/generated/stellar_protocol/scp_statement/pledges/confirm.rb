# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#           {
#               SCPBallot ballot;   // b
#               uint32 nPrepared;   // p.n
#               uint32 nCommit;     // c.n
#               uint32 nH;          // h.n
#               Hash quorumSetHash; // D
#           }
#
# ===========================================================================
module StellarProtocol
  class SCPStatement
    class Pledges
      class Confirm < XDR::Struct
        attribute :ballot,          SCPBallot
        attribute :n_prepared,      Uint32
        attribute :n_commit,        Uint32
        attribute :n_h,             Uint32
        attribute :quorum_set_hash, Hash
      end
    end
  end
end
