# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCNonceKey {
#       SCAddress nonce_address;
#   };
#
# ===========================================================================
module Stellar
  class SCNonceKey < XDR::Struct
    attribute :nonce_address, SCAddress
  end
end
