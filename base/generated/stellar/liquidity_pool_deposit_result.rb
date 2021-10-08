# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union LiquidityPoolDepositResult switch (
#       LiquidityPoolDepositResultCode code)
#   {
#   case LIQUIDITY_POOL_DEPOSIT_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class LiquidityPoolDepositResult < XDR::Union
    switch_on LiquidityPoolDepositResultCode, :code

    switch :liquidity_pool_deposit_success
    switch :default

  end
end
