# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ClaimableBalanceIDType
#   {
#       CLAIMABLE_BALANCE_ID_TYPE_V0 = 0
#   };
#
# ===========================================================================
module Stellar
  class ClaimableBalanceIDType < XDR::Enum
    member :claimable_balance_id_type_v0, 0

    seal
  end
end
