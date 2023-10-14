# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union BumpFootprintExpirationResult switch (BumpFootprintExpirationResultCode code)
#   {
#   case BUMP_FOOTPRINT_EXPIRATION_SUCCESS:
#       void;
#   case BUMP_FOOTPRINT_EXPIRATION_MALFORMED:
#   case BUMP_FOOTPRINT_EXPIRATION_RESOURCE_LIMIT_EXCEEDED:
#   case BUMP_FOOTPRINT_EXPIRATION_INSUFFICIENT_REFUNDABLE_FEE:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class BumpFootprintExpirationResult < XDR::Union
    switch_on BumpFootprintExpirationResultCode, :code

    switch :bump_footprint_expiration_success
    switch :bump_footprint_expiration_malformed
    switch :bump_footprint_expiration_resource_limit_exceeded
    switch :bump_footprint_expiration_insufficient_refundable_fee

  end
end
