# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           Hash hash;
#       }
#
# ===========================================================================
module Stellar
  class LedgerKey
    class ContractCode < XDR::Struct
      attribute :hash, Hash
    end
  end
end
