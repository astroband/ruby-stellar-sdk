# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID sellerID;
#           uint64 offerID;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class Offer < XDR::Struct
      attribute :seller_id, AccountID
      attribute :offer_id,  Uint64
    end
  end
end
