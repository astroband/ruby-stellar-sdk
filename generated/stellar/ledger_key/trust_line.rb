# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID accountID;
#           Currency currency;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class TrustLine < XDR::Struct
      attribute :account_id, AccountID
      attribute :currency,   Currency
    end
  end
end
