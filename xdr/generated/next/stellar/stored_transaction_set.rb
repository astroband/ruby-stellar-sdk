# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union StoredTransactionSet switch (int v)
#   {
#   case 0:
#   	TransactionSet txSet;
#   case 1:
#   	GeneralizedTransactionSet generalizedTxSet;
#   };
#
# ===========================================================================
module Stellar
  class StoredTransactionSet < XDR::Union
    switch_on XDR::Int, :v

    switch 0, :tx_set
    switch 1, :generalized_tx_set

    attribute :tx_set,             TransactionSet
    attribute :generalized_tx_set, GeneralizedTransactionSet
  end
end
