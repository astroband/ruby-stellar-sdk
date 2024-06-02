# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash networkID;
#           Hash contractID;
#           uint256 salt;
#       }
#
# ===========================================================================
module Stellar
  class HashIDPreimage
    class ContractID < XDR::Struct
      attribute :network_id,  Hash
      attribute :contract_id, Hash
      attribute :salt,        Uint256
    end
  end
end
