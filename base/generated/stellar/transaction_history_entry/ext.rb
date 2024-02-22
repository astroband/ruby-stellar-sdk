# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (int v)
#       {
#       case 0:
#           void;
#       case 1:
#           GeneralizedTransactionSet generalizedTxSet;
#       }
#
# ===========================================================================
module Stellar
  class TransactionHistoryEntry
    class Ext < XDR::Union
      switch_on XDR::Int, :v

      switch 0
      switch 1, :generalized_tx_set

      attribute :generalized_tx_set, GeneralizedTransactionSet
    end
  end
end
