# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum LedgerEntryType
#   {
#       ACCOUNT = 0,
#       TRUSTLINE = 1,
#       OFFER = 2
#   };
#
# ===========================================================================
module Stellar
  class LedgerEntryType < XDR::Enum
    member :account,   0
    member :trustline, 1
    member :offer,     2

    seal
  end
end
