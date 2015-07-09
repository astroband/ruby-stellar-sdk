# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Hello
#   {
#       uint32 ledgerVersion;
#       uint32 overlayVersion;
#       string versionStr<100>;
#       int listeningPort;
#       NodeID peerID;
#   };
#
# ===========================================================================
module Stellar
  class Hello < XDR::Struct
    attribute :ledger_version,  Uint32
    attribute :overlay_version, Uint32
    attribute :version_str,     XDR::String[100]
    attribute :listening_port,  XDR::Int
    attribute :peer_id,         NodeID
  end
end
