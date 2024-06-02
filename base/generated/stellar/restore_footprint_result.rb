# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union RestoreFootprintResult switch (RestoreFootprintResultCode code)
#   {
#   case RESTORE_FOOTPRINT_SUCCESS:
#       void;
#   case RESTORE_FOOTPRINT_MALFORMED:
#   case RESTORE_FOOTPRINT_RESOURCE_LIMIT_EXCEEDED:
#   case RESTORE_FOOTPRINT_INSUFFICIENT_REFUNDABLE_FEE:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class RestoreFootprintResult < XDR::Union
    switch_on RestoreFootprintResultCode, :code

    switch :restore_footprint_success
    switch :restore_footprint_malformed
    switch :restore_footprint_resource_limit_exceeded
    switch :restore_footprint_insufficient_refundable_fee

  end
end
