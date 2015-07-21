# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union TransactionMeta switch (int v)
#   {
#   case 0:
#       struct
#       {
#           LedgerEntryChanges changes;
#           OperationMeta operations<>;
#       } v0;
#   };
#
# ===========================================================================
module Stellar
  class TransactionMeta < XDR::Union
    include XDR::Namespace

    autoload :V0

    switch_on XDR::Int, :v

    switch 0, :v0

    attribute :v0, V0
  end
end
