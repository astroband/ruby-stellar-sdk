# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ExtendFootprintTTLResultCode
#   {
#       // codes considered as "success" for the operation
#       EXTEND_FOOTPRINT_TTL_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       EXTEND_FOOTPRINT_TTL_MALFORMED = -1,
#       EXTEND_FOOTPRINT_TTL_RESOURCE_LIMIT_EXCEEDED = -2,
#       EXTEND_FOOTPRINT_TTL_INSUFFICIENT_REFUNDABLE_FEE = -3
#   };
#
# ===========================================================================
module Stellar
  class ExtendFootprintTTLResultCode < XDR::Enum
    member :extend_footprint_ttl_success,                     0
    member :extend_footprint_ttl_malformed,                   -1
    member :extend_footprint_ttl_resource_limit_exceeded,     -2
    member :extend_footprint_ttl_insufficient_refundable_fee, -3

    seal
  end
end
