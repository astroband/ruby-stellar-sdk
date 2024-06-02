# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum OfferEntryFlags
#   {
#       // an offer with this flag will not act on and take a reverse offer of equal
#       // price
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
