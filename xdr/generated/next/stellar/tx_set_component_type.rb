# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum TxSetComponentType
#   {
#     // txs with effective fee <= bid derived from a base fee (if any).
#     // If base fee is not specified, no discount is applied.
#     TXSET_COMP_TXS_MAYBE_DISCOUNTED_FEE = 0
#   };
#
# ===========================================================================
module Stellar
  class TxSetComponentType < XDR::Enum
    member :txset_comp_txs_maybe_discounted_fee, 0

    seal
  end
end
