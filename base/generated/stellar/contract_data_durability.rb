# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ContractDataDurability {
#       TEMPORARY = 0,
#       PERSISTENT = 1
#   };
#
# ===========================================================================
module Stellar
  class ContractDataDurability < XDR::Enum
    member :temporary,  0
    member :persistent, 1

    seal
  end
end
