# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           ClaimableBalanceID balanceID;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class ClaimableBalance < XDR::Struct
      attribute :balance_id, ClaimableBalanceID
    end
  end
end
