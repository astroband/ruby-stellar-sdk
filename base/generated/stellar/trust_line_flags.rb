# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum TrustLineFlags
#   {
#       // issuer has authorized account to perform transactions with its credit
#       AUTHORIZED_FLAG = 1
#   };
#
# ===========================================================================
module Stellar
  class TrustLineFlags < XDR::Enum
    member :authorized_flag, 1

    seal
  end
end
