# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResultSetV2
#   {
#       TransactionResultPairV2 results<>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultSetV2 < XDR::Struct
    attribute :results, XDR::VarArray[TransactionResultPairV2]
  end
end
