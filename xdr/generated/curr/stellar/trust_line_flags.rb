# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum TrustLineFlags
#   {
#       // issuer has authorized account to perform transactions with its credit
#       AUTHORIZED_FLAG = 1,
#       // issuer has authorized account to maintain and reduce liabilities for its
#       // credit
#       AUTHORIZED_TO_MAINTAIN_LIABILITIES_FLAG = 2,
#       // issuer has specified that it may clawback its credit, and that claimable
#       // balances created with its credit may also be clawed back
#       TRUSTLINE_CLAWBACK_ENABLED_FLAG = 4
#   };
#
# ===========================================================================
module Stellar
  class TrustLineFlags < XDR::Enum
    member :authorized_flag,                         1
    member :authorized_to_maintain_liabilities_flag, 2
    member :trustline_clawback_enabled_flag,         4

    seal
  end
end
