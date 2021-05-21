# This code was automatically generated using xdrgen
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
module StellarProtocol
  class ChangeTrustResult < XDR::Union
    switch_on ChangeTrustResultCode, :code

    switch :change_trust_success
    switch :default

  end
end
