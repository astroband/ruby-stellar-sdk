# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID destination;    // The account that can use this condition
#           ClaimPredicate predicate; // Claimable if predicate is true
#       }
#
# ===========================================================================
module Stellar
  class Claimant
    class V0 < XDR::Struct
      attribute :destination, AccountID
      attribute :predicate,   ClaimPredicate
    end
  end
end
