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
#           SorobanTransactionData sorobanData;
#       }
#
# ===========================================================================
module Stellar
  class Transaction
    class Ext < XDR::Union
      switch_on XDR::Int, :v

      switch 0
      switch 1, :soroban_data

      attribute :soroban_data, SorobanTransactionData
    end
  end
end
