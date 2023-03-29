# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SendMore
#   {
#       uint32 numMessages;
#   };
#
# ===========================================================================
module Stellar
  class SendMore < XDR::Struct
    attribute :num_messages, Uint32
  end
end
