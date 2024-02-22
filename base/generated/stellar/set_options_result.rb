# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SetOptionsResult switch (SetOptionsResultCode code)
#   {
#   case SET_OPTIONS_SUCCESS:
#       void;
#   case SET_OPTIONS_LOW_RESERVE:
#   case SET_OPTIONS_TOO_MANY_SIGNERS:
#   case SET_OPTIONS_BAD_FLAGS:
#   case SET_OPTIONS_INVALID_INFLATION:
#   case SET_OPTIONS_CANT_CHANGE:
#   case SET_OPTIONS_UNKNOWN_FLAG:
#   case SET_OPTIONS_THRESHOLD_OUT_OF_RANGE:
#   case SET_OPTIONS_BAD_SIGNER:
#   case SET_OPTIONS_INVALID_HOME_DOMAIN:
#   case SET_OPTIONS_AUTH_REVOCABLE_REQUIRED:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class SetOptionsResult < XDR::Union
    switch_on SetOptionsResultCode, :code

    switch :set_options_success
    switch :set_options_low_reserve
    switch :set_options_too_many_signers
    switch :set_options_bad_flags
    switch :set_options_invalid_inflation
    switch :set_options_cant_change
    switch :set_options_unknown_flag
    switch :set_options_threshold_out_of_range
    switch :set_options_bad_signer
    switch :set_options_invalid_home_domain
    switch :set_options_auth_revocable_required

  end
end
