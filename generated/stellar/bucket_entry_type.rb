# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum BucketEntryType
#   {
#       LIVEENTRY = 0,
#       DEADENTRY = 1
#   };
#
# ===========================================================================
module Stellar
  class BucketEntryType < XDR::Enum
    member :liveentry, 0
    member :deadentry, 1

    seal
  end
end
