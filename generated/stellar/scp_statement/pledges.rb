# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (SCPStatementType type)
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
#
# ===========================================================================
module Stellar
  class SCPStatement
    class Pledges < XDR::Union
      include XDR::Namespace

      autoload :Prepare
      autoload :Confirm
      autoload :Externalize

      switch_on SCPStatementType, :type

      switch :scp_st_prepare,     :prepare
      switch :scp_st_confirm,     :confirm
      switch :scp_st_externalize, :externalize
      switch :scp_st_nominate,    :nominate

      attribute :prepare,     Prepare
      attribute :confirm,     Confirm
      attribute :externalize, Externalize
      attribute :nominate,    SCPNomination
    end
  end
end
