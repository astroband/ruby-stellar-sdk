# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           SCAddress address;
#           uint256 salt;
#       }
#
# ===========================================================================
module Stellar
  class ContractIDPreimage
    class FromAddress < XDR::Struct
      attribute :address, SCAddress
      attribute :salt,    Uint256
    end
  end
end
