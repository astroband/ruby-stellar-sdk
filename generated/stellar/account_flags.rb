# Automatically generated on 2015-06-08T11:39:14-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum AccountFlags
#   { // masks for each flag
#   
#       // if set, TrustLines are created with authorized set to "false"
#       // requiring the issuer to set it for each TrustLine
#       AUTH_REQUIRED_FLAG = 0x1,
#       // if set, the authorized flag in TrustTines can be cleared
#       // otherwise, authorization cannot be revoked
#       AUTH_REVOCABLE_FLAG = 0x2
#   };
#
# ===========================================================================
module Stellar
  class AccountFlags < XDR::Enum
    member :auth_required_flag,  1
    member :auth_revocable_flag, 2

    seal
  end
end
