# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ExtendFootprintTTLResult switch (ExtendFootprintTTLResultCode code)
#   {
#   case EXTEND_FOOTPRINT_TTL_SUCCESS:
#       void;
#   case EXTEND_FOOTPRINT_TTL_MALFORMED:
#   case EXTEND_FOOTPRINT_TTL_RESOURCE_LIMIT_EXCEEDED:
#   case EXTEND_FOOTPRINT_TTL_INSUFFICIENT_REFUNDABLE_FEE:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ExtendFootprintTTLResult < XDR::Union
    switch_on ExtendFootprintTTLResultCode, :code

    switch :extend_footprint_ttl_success
    switch :extend_footprint_ttl_malformed
    switch :extend_footprint_ttl_resource_limit_exceeded
    switch :extend_footprint_ttl_insufficient_refundable_fee

  end
end
