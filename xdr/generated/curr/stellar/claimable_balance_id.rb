# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ClaimableBalanceID switch (ClaimableBalanceIDType type)
#   {
#   case CLAIMABLE_BALANCE_ID_TYPE_V0:
#       Hash v0;
#   };
#
# ===========================================================================
module Stellar
  class ClaimableBalanceID < XDR::Union
    switch_on ClaimableBalanceIDType, :type

    switch :claimable_balance_id_type_v0, :v0

    attribute :v0, Hash
  end
end
