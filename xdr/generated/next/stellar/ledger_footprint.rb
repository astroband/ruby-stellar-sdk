# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerFootprint
#   {
#       LedgerKey readOnly<>;
#       LedgerKey readWrite<>;
#   };
#
# ===========================================================================
module Stellar
  class LedgerFootprint < XDR::Struct
    attribute :read_only,  XDR::VarArray[LedgerKey]
    attribute :read_write, XDR::VarArray[LedgerKey]
  end
end
