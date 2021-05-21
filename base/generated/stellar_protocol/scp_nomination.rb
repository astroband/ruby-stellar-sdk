# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCPNomination
#   {
#       Hash quorumSetHash; // D
#       Value votes<>;      // X
#       Value accepted<>;   // Y
#   };
#
# ===========================================================================
module StellarProtocol
  class SCPNomination < XDR::Struct
    attribute :quorum_set_hash, Hash
    attribute :votes,           XDR::VarArray[Value]
    attribute :accepted,        XDR::VarArray[Value]
  end
end
