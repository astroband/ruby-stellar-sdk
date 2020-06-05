# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ErrorCode
#   {
#       ERR_MISC = 0, // Unspecific error
#       ERR_DATA = 1, // Malformed data
#       ERR_CONF = 2, // Misconfiguration error
#       ERR_AUTH = 3, // Authentication failure
#       ERR_LOAD = 4  // System overloaded
#   };
#
# ===========================================================================
module Stellar
  class ErrorCode < XDR::Enum
    member :err_misc, 0
    member :err_data, 1
    member :err_conf, 2
    member :err_auth, 3
    member :err_load, 4

    seal
  end
end
