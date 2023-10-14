# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ClawbackResult switch (ClawbackResultCode code)
#   {
#   case CLAWBACK_SUCCESS:
#       void;
#   case CLAWBACK_MALFORMED:
#   case CLAWBACK_NOT_CLAWBACK_ENABLED:
#   case CLAWBACK_NO_TRUST:
#   case CLAWBACK_UNDERFUNDED:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ClawbackResult < XDR::Union
    switch_on ClawbackResultCode, :code

    switch :clawback_success
    switch :clawback_malformed
    switch :clawback_not_clawback_enabled
    switch :clawback_no_trust
    switch :clawback_underfunded

  end
end
