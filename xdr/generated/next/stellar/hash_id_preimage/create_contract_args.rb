# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash networkID;
#           SCContractExecutable source;
#           uint256 salt;
#       }
#
# ===========================================================================
module Stellar
  class HashIDPreimage
    class CreateContractArgs < XDR::Struct
      attribute :network_id, Hash
      attribute :source,     SCContractExecutable
      attribute :salt,       Uint256
    end
  end
end
