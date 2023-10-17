# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ContractDataEntry {
#       ExtensionPoint ext;
#
#       SCAddress contract;
#       SCVal key;
#       ContractDataDurability durability;
#       SCVal val;
#   };
#
# ===========================================================================
module Stellar
  class ContractDataEntry < XDR::Struct
    attribute :ext,        ExtensionPoint
    attribute :contract,   SCAddress
    attribute :key,        SCVal
    attribute :durability, ContractDataDurability
    attribute :val,        SCVal
  end
end
