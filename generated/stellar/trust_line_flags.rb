# Automatically generated on 2015-05-12T09:08:23-07:00
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
