# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash networkID;
#           uint256 ed25519;
#           uint256 salt;
#       }
#
# ===========================================================================
module Stellar
  class HashIDPreimage
    class Ed25519ContractID < XDR::Struct
      attribute :network_id, Hash
      attribute :ed25519,    Uint256
      attribute :salt,       Uint256
    end
  end
end
