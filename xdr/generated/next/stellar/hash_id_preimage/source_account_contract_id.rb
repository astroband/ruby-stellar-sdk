# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash networkID;
#           AccountID sourceAccount;
#           uint256 salt;
#       }
#
# ===========================================================================
module Stellar
  class HashIDPreimage
    class SourceAccountContractID < XDR::Struct
      attribute :network_id,     Hash
      attribute :source_account, AccountID
      attribute :salt,           Uint256
    end
  end
end
