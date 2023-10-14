# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Auth
#   {
#       int flags;
#   };
#
# ===========================================================================
module Stellar
  class Auth < XDR::Struct
    attribute :flags, XDR::Int
  end
end
