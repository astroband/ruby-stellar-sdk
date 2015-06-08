# Automatically generated on 2015-06-08T11:39:14-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum OfferEntryFlags
#   {
#       // issuer has authorized account to perform transactions with its credit
#       PASSIVE_FLAG = 1
#   };
#
# ===========================================================================
module Stellar
  class OfferEntryFlags < XDR::Enum
    member :passive_flag, 1

    seal
  end
end
