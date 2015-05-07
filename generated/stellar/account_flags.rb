# Automatically generated on 2015-05-07T07:56:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum AccountFlags
#   { // masks for each flag
#       AUTH_REQUIRED_FLAG = 0x1,
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
