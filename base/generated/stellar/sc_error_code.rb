# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCErrorCode
#   {
#       SCEC_ARITH_DOMAIN = 0,      // Some arithmetic was undefined (overflow, divide-by-zero).
#       SCEC_INDEX_BOUNDS = 1,      // Something was indexed beyond its bounds.
#       SCEC_INVALID_INPUT = 2,     // User provided some otherwise-bad data.
#       SCEC_MISSING_VALUE = 3,     // Some value was required but not provided.
#       SCEC_EXISTING_VALUE = 4,    // Some value was provided where not allowed.
#       SCEC_EXCEEDED_LIMIT = 5,    // Some arbitrary limit -- gas or otherwise -- was hit.
#       SCEC_INVALID_ACTION = 6,    // Data was valid but action requested was not.
#       SCEC_INTERNAL_ERROR = 7,    // The host detected an error in its own logic.
#       SCEC_UNEXPECTED_TYPE = 8,   // Some type wasn't as expected.
#       SCEC_UNEXPECTED_SIZE = 9    // Something's size wasn't as expected.
#   };
#
# ===========================================================================
module Stellar
  class SCErrorCode < XDR::Enum
    member :scec_arith_domain,    0
    member :scec_index_bounds,    1
    member :scec_invalid_input,   2
    member :scec_missing_value,   3
    member :scec_existing_value,  4
    member :scec_exceeded_limit,  5
    member :scec_invalid_action,  6
    member :scec_internal_error,  7
    member :scec_unexpected_type, 8
    member :scec_unexpected_size, 9

    seal
  end
end
