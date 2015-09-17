# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union TransactionMeta switch (int v)
#   {
#   case 0:
#       OperationMeta operations<>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionMeta < XDR::Union
    switch_on XDR::Int, :v

    switch 0, :operations

    attribute :operations, XDR::VarArray[OperationMeta]
  end
end
