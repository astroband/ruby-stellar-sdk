# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SendMoreExtended
#   {
#       uint32 numMessages;
#       uint32 numBytes;
#   };
#
# ===========================================================================
module Stellar
  class SendMoreExtended < XDR::Struct
    attribute :num_messages, Uint32
    attribute :num_bytes,    Uint32
  end
end
