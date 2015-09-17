# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Auth
#   {
#       Signature signature;
#   };
#
# ===========================================================================
module Stellar
  class Auth < XDR::Struct
    attribute :signature, Signature
  end
end
