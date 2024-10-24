# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union TxSetComponent switch (TxSetComponentType type)
#   {
#   case TXSET_COMP_TXS_MAYBE_DISCOUNTED_FEE:
#     struct
#     {
#       int64* baseFee;
#       TransactionEnvelope txs<>;
#     } txsMaybeDiscountedFee;
#   };
#
# ===========================================================================
module Stellar
  class TxSetComponent < XDR::Union
    include XDR::Namespace

    autoload :TxsMaybeDiscountedFee

    switch_on TxSetComponentType, :type

    switch :txset_comp_txs_maybe_discounted_fee, :txs_maybe_discounted_fee

    attribute :txs_maybe_discounted_fee, TxsMaybeDiscountedFee
  end
end
