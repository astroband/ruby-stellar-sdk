# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union AllowTrustResult switch (AllowTrustResultCode code)
#   {
#   case ALLOW_TRUST_SUCCESS:
#       void;
#   case ALLOW_TRUST_MALFORMED:
#   case ALLOW_TRUST_NO_TRUST_LINE:
#   case ALLOW_TRUST_TRUST_NOT_REQUIRED:
#   case ALLOW_TRUST_CANT_REVOKE:
#   case ALLOW_TRUST_SELF_NOT_ALLOWED:
#   case ALLOW_TRUST_LOW_RESERVE:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class AllowTrustResult < XDR::Union
    switch_on AllowTrustResultCode, :code

    switch :allow_trust_success
    switch :allow_trust_malformed
    switch :allow_trust_no_trust_line
    switch :allow_trust_trust_not_required
    switch :allow_trust_cant_revoke
    switch :allow_trust_self_not_allowed
    switch :allow_trust_low_reserve

  end
end
