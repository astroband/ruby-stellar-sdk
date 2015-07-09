# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union AllowTrustResult switch (AllowTrustResultCode code)
#   {
#   case ALLOW_TRUST_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class AllowTrustResult < XDR::Union
    switch_on AllowTrustResultCode, :code

    switch :allow_trust_success
    switch :default

  end
end
