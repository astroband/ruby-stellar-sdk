# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum BumpFootprintExpirationResultCode
#   {
#       // codes considered as "success" for the operation
#       BUMP_FOOTPRINT_EXPIRATION_SUCCESS = 0,
#
#       // codes considered as "failure" for the operation
#       BUMP_FOOTPRINT_EXPIRATION_MALFORMED = -1,
#       BUMP_FOOTPRINT_EXPIRATION_RESOURCE_LIMIT_EXCEEDED = -2,
#       BUMP_FOOTPRINT_EXPIRATION_INSUFFICIENT_REFUNDABLE_FEE = -3
#   };
#
# ===========================================================================
module Stellar
  class BumpFootprintExpirationResultCode < XDR::Enum
    member :bump_footprint_expiration_success,                     0
    member :bump_footprint_expiration_malformed,                   -1
    member :bump_footprint_expiration_resource_limit_exceeded,     -2
    member :bump_footprint_expiration_insufficient_refundable_fee, -3

    seal
  end
end
