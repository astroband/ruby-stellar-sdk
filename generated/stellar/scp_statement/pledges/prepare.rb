# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#           {
#               Hash quorumSetHash;       // D
#               SCPBallot ballot;         // b
#               SCPBallot* prepared;      // p
#               SCPBallot* preparedPrime; // p'
#               uint32 nC;                // n_c
#               uint32 nP;                // n_P
#           }
#
# ===========================================================================
module Stellar
  class SCPStatement
    class Pledges
      class Prepare < XDR::Struct
        attribute :quorum_set_hash, Hash
        attribute :ballot,          SCPBallot
        attribute :prepared,        XDR::Option[SCPBallot]
        attribute :prepared_prime,  XDR::Option[SCPBallot]
        attribute :n_c,             Uint32
        attribute :n_p,             Uint32
      end
    end
  end
end
