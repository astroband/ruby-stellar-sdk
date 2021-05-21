# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SetTrustLineFlagsResult switch (SetTrustLineFlagsResultCode code)
#   {
#   case SET_TRUST_LINE_FLAGS_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module StellarProtocol
  class SetTrustLineFlagsResult < XDR::Union
    switch_on SetTrustLineFlagsResultCode, :code

    switch :set_trust_line_flags_success
    switch :default

  end
end
