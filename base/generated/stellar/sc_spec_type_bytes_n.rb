# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecTypeBytesN
#   {
#       uint32 n;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecTypeBytesN < XDR::Struct
    attribute :n, Uint32
  end
end
