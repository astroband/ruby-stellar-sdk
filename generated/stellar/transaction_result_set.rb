# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResultSet
#   {
#       TransactionResultPair results<>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultSet < XDR::Struct
    attribute :results, XDR::VarArray[TransactionResultPair]
  end
end
