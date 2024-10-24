# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           SCAddress contract;
#           SCVal key;
#           ContractDataDurability durability;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class ContractData < XDR::Struct
      attribute :contract,   SCAddress
      attribute :key,        SCVal
      attribute :durability, ContractDataDurability
    end
  end
end
