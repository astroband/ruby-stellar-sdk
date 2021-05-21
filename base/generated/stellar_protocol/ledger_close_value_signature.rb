# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerCloseValueSignature
#   {
#       NodeID nodeID;       // which node introduced the value
#       Signature signature; // nodeID's signature
#   };
#
# ===========================================================================
module StellarProtocol
  class LedgerCloseValueSignature < XDR::Struct
    attribute :node_id,   NodeID
    attribute :signature, Signature
  end
end
