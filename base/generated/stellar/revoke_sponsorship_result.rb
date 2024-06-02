# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union RevokeSponsorshipResult switch (RevokeSponsorshipResultCode code)
#   {
#   case REVOKE_SPONSORSHIP_SUCCESS:
#       void;
#   case REVOKE_SPONSORSHIP_DOES_NOT_EXIST:
#   case REVOKE_SPONSORSHIP_NOT_SPONSOR:
#   case REVOKE_SPONSORSHIP_LOW_RESERVE:
#   case REVOKE_SPONSORSHIP_ONLY_TRANSFERABLE:
#   case REVOKE_SPONSORSHIP_MALFORMED:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class RevokeSponsorshipResult < XDR::Union
    switch_on RevokeSponsorshipResultCode, :code

    switch :revoke_sponsorship_success
    switch :revoke_sponsorship_does_not_exist
    switch :revoke_sponsorship_not_sponsor
    switch :revoke_sponsorship_low_reserve
    switch :revoke_sponsorship_only_transferable
    switch :revoke_sponsorship_malformed

  end
end
