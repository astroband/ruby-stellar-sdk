# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TopologyResponseBodyV0
#   {
#       PeerStatList inboundPeers;
#       PeerStatList outboundPeers;
#
#       uint32 totalInboundPeerCount;
#       uint32 totalOutboundPeerCount;
#   };
#
# ===========================================================================
module Stellar
  class TopologyResponseBodyV0 < XDR::Struct
    attribute :inbound_peers,             PeerStatList
    attribute :outbound_peers,            PeerStatList
    attribute :total_inbound_peer_count,  Uint32
    attribute :total_outbound_peer_count, Uint32
  end
end
