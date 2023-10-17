# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct PeerStats
#   {
#       NodeID id;
#       string versionStr<100>;
#       uint64 messagesRead;
#       uint64 messagesWritten;
#       uint64 bytesRead;
#       uint64 bytesWritten;
#       uint64 secondsConnected;
#
#       uint64 uniqueFloodBytesRecv;
#       uint64 duplicateFloodBytesRecv;
#       uint64 uniqueFetchBytesRecv;
#       uint64 duplicateFetchBytesRecv;
#
#       uint64 uniqueFloodMessageRecv;
#       uint64 duplicateFloodMessageRecv;
#       uint64 uniqueFetchMessageRecv;
#       uint64 duplicateFetchMessageRecv;
#   };
#
# ===========================================================================
module Stellar
  class PeerStats < XDR::Struct
    attribute :id,                           NodeID
    attribute :version_str,                  XDR::String[100]
    attribute :messages_read,                Uint64
    attribute :messages_written,             Uint64
    attribute :bytes_read,                   Uint64
    attribute :bytes_written,                Uint64
    attribute :seconds_connected,            Uint64
    attribute :unique_flood_bytes_recv,      Uint64
    attribute :duplicate_flood_bytes_recv,   Uint64
    attribute :unique_fetch_bytes_recv,      Uint64
    attribute :duplicate_fetch_bytes_recv,   Uint64
    attribute :unique_flood_message_recv,    Uint64
    attribute :duplicate_flood_message_recv, Uint64
    attribute :unique_fetch_message_recv,    Uint64
    attribute :duplicate_fetch_message_recv, Uint64
  end
end
