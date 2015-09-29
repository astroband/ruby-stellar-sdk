# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Auth
#   {
#       // Empty message, just to confirm
#       // establishment of MAC keys.
#       int unused;
#   };
#
# ===========================================================================
module Stellar
  class Auth < XDR::Struct
    attribute :unused, XDR::Int
  end
end
