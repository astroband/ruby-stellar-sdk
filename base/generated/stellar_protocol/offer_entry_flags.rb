# This code was automatically generated using xdrgen
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
module StellarProtocol
  class OfferEntryFlags < XDR::Enum
    member :passive_flag, 1

    seal
  end
end
