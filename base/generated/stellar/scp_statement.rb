# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCPStatement
#   {
#       NodeID nodeID;    // v
#       uint64 slotIndex; // i
#
#       union switch (SCPStatementType type)
#       {
#       case SCP_ST_PREPARE:
#           struct
#           {
#               Hash quorumSetHash;       // D
#               SCPBallot ballot;         // b
#               SCPBallot* prepared;      // p
#               SCPBallot* preparedPrime; // p'
#               uint32 nC;                // c.n
#               uint32 nH;                // h.n
#           } prepare;
#       case SCP_ST_CONFIRM:
#           struct
#           {
#               SCPBallot ballot;   // b
#               uint32 nPrepared;   // p.n
#               uint32 nCommit;     // c.n
#               uint32 nH;          // h.n
#               Hash quorumSetHash; // D
#           } confirm;
#       case SCP_ST_EXTERNALIZE:
#           struct
#           {
#               SCPBallot commit;         // c
#               uint32 nH;                // h.n
#               Hash commitQuorumSetHash; // D used before EXTERNALIZE
#           } externalize;
#       case SCP_ST_NOMINATE:
#           SCPNomination nominate;
#       }
#       pledges;
#   };
#
# ===========================================================================
module Stellar
  class SCPStatement < XDR::Struct
    include XDR::Namespace

    autoload :Pledges

    attribute :node_id,    NodeID
    attribute :slot_index, Uint64
    attribute :pledges,    Pledges
  end
end
