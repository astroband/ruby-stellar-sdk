# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ClawbackResult switch (ClawbackResultCode code)
#   {
#   case CLAWBACK_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ClawbackResult < XDR::Union
    switch_on ClawbackResultCode, :code

    switch :clawback_success
    switch :default

  end
end
