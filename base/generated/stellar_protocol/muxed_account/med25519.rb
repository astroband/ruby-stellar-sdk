# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           uint64 id;
#           uint256 ed25519;
#       }
#
# ===========================================================================
module StellarProtocol
  class MuxedAccount
    class Med25519 < XDR::Struct
      attribute :id,      Uint64
      attribute :ed25519, Uint256
    end
  end
end
