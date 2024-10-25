# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ClaimantType
#   {
#       CLAIMANT_TYPE_V0 = 0
#   };
#
# ===========================================================================
module Stellar
  class ClaimantType < XDR::Enum
    member :claimant_type_v0, 0

    seal
  end
end
