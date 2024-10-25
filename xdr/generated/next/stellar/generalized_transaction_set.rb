# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union GeneralizedTransactionSet switch (int v)
#   {
#   // We consider the legacy TransactionSet to be v0.
#   case 1:
#       TransactionSetV1 v1TxSet;
#   };
#
# ===========================================================================
module Stellar
  class GeneralizedTransactionSet < XDR::Union
    switch_on XDR::Int, :v

    switch 1, :v1_tx_set

    attribute :v1_tx_set, TransactionSetV1
  end
end
