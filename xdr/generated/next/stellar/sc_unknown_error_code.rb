# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCUnknownErrorCode
#   {
#       UNKNOWN_ERROR_GENERAL = 0,
#       UNKNOWN_ERROR_XDR = 1
#   };
#
# ===========================================================================
module Stellar
  class SCUnknownErrorCode < XDR::Enum
    member :unknown_error_general, 0
    member :unknown_error_xdr,     1

    seal
  end
end
