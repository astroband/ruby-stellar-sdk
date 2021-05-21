# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum BucketEntryType
#   {
#       METAENTRY =
#           -1, // At-and-after protocol 11: bucket metadata, should come first.
#       LIVEENTRY = 0, // Before protocol 11: created-or-updated;
#                      // At-and-after protocol 11: only updated.
#       DEADENTRY = 1,
#       INITENTRY = 2 // At-and-after protocol 11: only created.
#   };
#
# ===========================================================================
module StellarProtocol
  class BucketEntryType < XDR::Enum
    member :metaentry, -1
    member :liveentry, 0
    member :deadentry, 1
    member :initentry, 2

    seal
  end
end
