# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum TrustLineFlags
#   {
#       AUTHORIZED_FLAG = 1 // issuer has authorized account to hold its credit
#   };
#
# ===========================================================================
module Stellar
  class TrustLineFlags < XDR::Enum
    member :authorized_flag, 1

    seal
  end
end
