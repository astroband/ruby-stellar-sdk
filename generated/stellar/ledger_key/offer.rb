# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID sellerID;
#           int64 offerID;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class Offer < XDR::Struct
      attribute :seller_id, AccountID
      attribute :offer_id,  Int64
    end
  end
end
