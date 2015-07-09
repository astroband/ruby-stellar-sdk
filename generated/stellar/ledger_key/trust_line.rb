# This code was automatically generated using xdrgen
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
