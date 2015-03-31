# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID accountID;
#           uint64 offerID;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class Offer < XDR::Struct
      attribute :account_id, AccountID
      attribute :offer_id,   Uint64
    end
  end
end
