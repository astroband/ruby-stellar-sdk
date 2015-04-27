# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum AccountFlags
#   { // masks for each flag
#       AUTH_REQUIRED_FLAG = 0x1
#   };
#
# ===========================================================================
module Stellar
  class AccountFlags < XDR::Enum
    member :auth_required_flag, 1

    seal
  end
end
