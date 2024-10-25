# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#     {
#       int64* baseFee;
#       TransactionEnvelope txs<>;
#     }
#
# ===========================================================================
module Stellar
  class TxSetComponent
    class TxsMaybeDiscountedFee < XDR::Struct
      attribute :base_fee, XDR::Option[Int64]
      attribute :txs,      XDR::VarArray[TransactionEnvelope]
    end
  end
end
