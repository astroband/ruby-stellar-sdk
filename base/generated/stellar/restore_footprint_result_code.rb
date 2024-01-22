# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum RestoreFootprintResultCode
#   {
#       // codes considered as "success" for the operation
#       RESTORE_FOOTPRINT_SUCCESS = 0,
#   
#       // codes considered as "failure" for the operation
#       RESTORE_FOOTPRINT_MALFORMED = -1,
#       RESTORE_FOOTPRINT_RESOURCE_LIMIT_EXCEEDED = -2,
#       RESTORE_FOOTPRINT_INSUFFICIENT_REFUNDABLE_FEE = -3
#   };
#
# ===========================================================================
module Stellar
  class RestoreFootprintResultCode < XDR::Enum
    member :restore_footprint_success,                     0
    member :restore_footprint_malformed,                   -1
    member :restore_footprint_resource_limit_exceeded,     -2
    member :restore_footprint_insufficient_refundable_fee, -3

    seal
  end
end
