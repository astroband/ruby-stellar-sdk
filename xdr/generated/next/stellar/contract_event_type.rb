# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ContractEventType
#   {
#       SYSTEM = 0,
#       CONTRACT = 1,
#       DIAGNOSTIC = 2
#   };
#
# ===========================================================================
module Stellar
  class ContractEventType < XDR::Enum
    member :system,     0
    member :contract,   1
    member :diagnostic, 2

    seal
  end
end
