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
#               uint32 nC;                // n_c
#               uint32 nP;                // n_P
#           } prepare;
#       case SCP_ST_CONFIRM:
#           struct
#           {
#               Hash quorumSetHash; // D
#               uint32 nPrepared;   // n_p
#               SCPBallot commit;   // c
#               uint32 nP;          // n_P
#           } confirm;
#       case SCP_ST_EXTERNALIZE:
#           struct
#           {
#               SCPBallot commit; // c
#               uint32 nP;        // n_P
#               // not from the paper, but useful to build tooling to
#               // traverse the graph based off only the latest statement
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
