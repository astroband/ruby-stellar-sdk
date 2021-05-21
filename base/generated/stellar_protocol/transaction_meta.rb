# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union TransactionMeta switch (int v)
#   {
#   case 0:
#       OperationMeta operations<>;
#   case 1:
#       TransactionMetaV1 v1;
#   case 2:
#       TransactionMetaV2 v2;
#   };
#
# ===========================================================================
module StellarProtocol
  class TransactionMeta < XDR::Union
    switch_on XDR::Int, :v

    switch 0, :operations
    switch 1, :v1
    switch 2, :v2

    attribute :operations, XDR::VarArray[OperationMeta]
    attribute :v1,         TransactionMetaV1
    attribute :v2,         TransactionMetaV2
  end
end
