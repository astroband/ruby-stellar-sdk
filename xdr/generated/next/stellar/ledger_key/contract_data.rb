# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash contractID;
#           SCVal key;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class ContractData < XDR::Struct
      attribute :contract_id, Hash
      attribute :key,         SCVal
    end
  end
end
