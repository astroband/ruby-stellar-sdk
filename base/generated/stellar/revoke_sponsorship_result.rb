# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union RevokeSponsorshipResult switch (RevokeSponsorshipResultCode code)
#   {
#   case REVOKE_SPONSORSHIP_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class RevokeSponsorshipResult < XDR::Union
    switch_on RevokeSponsorshipResultCode, :code

    switch :revoke_sponsorship_success
    switch :default

  end
end
