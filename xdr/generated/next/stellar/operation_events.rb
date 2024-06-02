# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct OperationEvents
#   {
#       ContractEvent events<>;
#   };
#
# ===========================================================================
module Stellar
  class OperationEvents < XDR::Struct
    attribute :events, XDR::VarArray[ContractEvent]
  end
end
