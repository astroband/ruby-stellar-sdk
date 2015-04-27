# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID accountID;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class Account < XDR::Struct
      attribute :account_id, AccountID
    end
  end
end
