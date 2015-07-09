# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#           {
#               Hash quorumSetHash; // D
#               uint32 nPrepared;   // n_p
#               SCPBallot commit;   // c
#               uint32 nP;          // n_P
#           }
#
# ===========================================================================
module Stellar
  class SCPStatement
    class Pledges
      class Confirm < XDR::Struct
        attribute :quorum_set_hash, Hash
        attribute :n_prepared,      Uint32
        attribute :commit,          SCPBallot
        attribute :n_p,             Uint32
      end
    end
  end
end
