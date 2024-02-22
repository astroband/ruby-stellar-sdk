# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ContractDataEntry {
#       Hash contractID;
#       SCVal key;
#       SCVal val;
#   };
#
# ===========================================================================
module Stellar
  class ContractDataEntry < XDR::Struct
    attribute :contract_id, Hash
    attribute :key,         SCVal
    attribute :val,         SCVal
  end
end
