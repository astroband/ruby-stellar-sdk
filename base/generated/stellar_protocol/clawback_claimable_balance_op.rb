# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ClawbackClaimableBalanceOp
#   {
#       ClaimableBalanceID balanceID;
#   };
#
# ===========================================================================
module StellarProtocol
  class ClawbackClaimableBalanceOp < XDR::Struct
    attribute :balance_id, ClaimableBalanceID
  end
end
