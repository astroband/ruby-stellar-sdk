# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCHostAuthErrorCode
#   {
#       HOST_AUTH_UNKNOWN_ERROR = 0,
#       HOST_AUTH_NONCE_ERROR = 1,
#       HOST_AUTH_DUPLICATE_AUTHORIZATION = 2,
#       HOST_AUTH_NOT_AUTHORIZED = 3
#   };
#
# ===========================================================================
module Stellar
  class SCHostAuthErrorCode < XDR::Enum
    member :host_auth_unknown_error,           0
    member :host_auth_nonce_error,             1
    member :host_auth_duplicate_authorization, 2
    member :host_auth_not_authorized,          3

    seal
  end
end
