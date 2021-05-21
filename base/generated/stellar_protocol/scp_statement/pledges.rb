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
#
# ===========================================================================
module StellarProtocol
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
