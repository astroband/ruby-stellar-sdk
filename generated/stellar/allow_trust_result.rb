# Automatically generated on 2015-03-31T14:32:44-07:00
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
