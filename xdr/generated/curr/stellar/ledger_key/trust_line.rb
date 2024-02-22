# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID accountID;
#           TrustLineAsset asset;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class TrustLine < XDR::Struct
      attribute :account_id, AccountID
      attribute :asset,      TrustLineAsset
    end
  end
end
