# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SetOptionsResultCode
#   {
#       // codes considered as "success" for the operation
#       SET_OPTIONS_SUCCESS = 0,
#       // codes considered as "failure" for the operation
#       SET_OPTIONS_LOW_RESERVE = -1,      // not enough funds to add a signer
#       SET_OPTIONS_TOO_MANY_SIGNERS = -2, // max number of signers already reached
#       SET_OPTIONS_BAD_FLAGS = -3,        // invalid combination of clear/set flags
#       SET_OPTIONS_INVALID_INFLATION = -4,      // inflation account does not exist
#       SET_OPTIONS_CANT_CHANGE = -5,            // can no longer change this option
#       SET_OPTIONS_UNKNOWN_FLAG = -6,           // can't set an unknown flag
#       SET_OPTIONS_THRESHOLD_OUT_OF_RANGE = -7, // bad value for weight/threshold
#       SET_OPTIONS_BAD_SIGNER = -8,             // signer cannot be masterkey
#       SET_OPTIONS_INVALID_HOME_DOMAIN = -9     // malformed home domain
#   };
#
# ===========================================================================
module Stellar
  class SetOptionsResultCode < XDR::Enum
    member :set_options_success,                0
    member :set_options_low_reserve,            -1
    member :set_options_too_many_signers,       -2
    member :set_options_bad_flags,              -3
    member :set_options_invalid_inflation,      -4
    member :set_options_cant_change,            -5
    member :set_options_unknown_flag,           -6
    member :set_options_threshold_out_of_range, -7
    member :set_options_bad_signer,             -8
    member :set_options_invalid_home_domain,    -9

    seal
  end
end
