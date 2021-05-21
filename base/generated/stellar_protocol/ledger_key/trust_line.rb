# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID accountID;
#           Asset asset;
#       }
#
# ===========================================================================
module StellarProtocol
  class LedgerKey
    class TrustLine < XDR::Struct
      attribute :account_id, AccountID
      attribute :asset,      Asset
    end
  end
end
