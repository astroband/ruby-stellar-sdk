# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union ChangeTrustResult switch (ChangeTrustResultCode code)
#   {
#   case CHANGE_TRUST_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ChangeTrustResult < XDR::Union
    switch_on ChangeTrustResultCode, :code

    switch :change_trust_success
    switch :default

  end
end
