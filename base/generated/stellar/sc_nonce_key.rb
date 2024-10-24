# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCNonceKey {
#       int64 nonce;
#   };
#
# ===========================================================================
module Stellar
  class SCNonceKey < XDR::Struct
    attribute :nonce, Int64
  end
end
