# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ClaimClaimableBalanceOp
#   {
#       ClaimableBalanceID balanceID;
#   };
#
# ===========================================================================
module Stellar
  class ClaimClaimableBalanceOp < XDR::Struct
    attribute :balance_id, ClaimableBalanceID
  end
end
