# This code was automatically generated using xdrgen
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
module StellarProtocol
  class LedgerKey
    class Account < XDR::Struct
      attribute :account_id, AccountID
    end
  end
end
